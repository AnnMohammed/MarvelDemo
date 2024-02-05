//
//  ViewController.swift
//  Marvel
//
//  Created by Ann Mohamed on 02/02/2024.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "images")
        return imageView
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)

        Observable.just(())
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.animating()
            })
            .disposed(by: disposeBag)
    }

    private func animating() {
        Observable.combineLatest(
            animateSize(),
            animateAlpha()
        )
        .take(1)
        .subscribe(onCompleted: { [weak self] in
            self?.presentCharacterListViewController()
        })
        .disposed(by: disposeBag)
    }

    private func animateSize() -> Observable<Void> {
        return Observable.create { [weak self] observer in
            UIView.animate(withDuration: 1, animations: {
                guard let self = self else { return }
                let size = self.view.frame.size.width * 3
                let diffx = size - self.view.frame.size.width
                let diffy = self.view.frame.size.height - size

                self.imageView.frame = CGRect(x: -(diffx / 2),
                                              y: (diffy / 2),
                                              width: size,
                                              height: size)
            }, completion: { _ in
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }

    private func animateAlpha() -> Observable<Void> {
        return Observable.create { [weak self] observer in
            UIView.animate(withDuration: 1.5, animations: {
                self?.imageView.alpha = 0
            }, completion: { _ in
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }

    private func presentCharacterListViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let viewController = CharcterListViewController()
            viewController.modalPresentationStyle = .fullScreen
            self?.present(viewController, animated: true)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
    }
}

