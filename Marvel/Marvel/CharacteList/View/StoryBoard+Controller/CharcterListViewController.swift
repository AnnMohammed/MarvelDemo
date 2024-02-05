//
//  CharcterListViewController.swift
//  Marvel
//
//  Created by Ann Mohamed on 02/02/2024.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class CharcterListViewController: BaseViewConttroller {
    
    @IBOutlet weak var chracterContainerView: UIView!
    
    @IBOutlet weak var charctersTableView: UITableView!{
        didSet{
            setupTableView()
        }
    }
    
    let charctersViewModel = CharctersViewModel()
    
    
    let sharedViewModel = SharedViewModel()
    func navigateToDestination(selectedCharacter: Resulting) {
           sharedViewModel.selectedCharacter.accept(selectedCharacter)
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToLoading()
    }
    
    override func bind() {
        super.bind()
        
        getcharcters()
        
        subscribeToResponse()
        
        charctersViewModel.showAlert.observeOn(MainScheduler.instance).asObservable().subscribe { [weak self] alert in
            
            guard let self = self else {return}
            
            self.makeOkAlert(title: "", SubTitle: alert, Image: UIImage())
            
        }.disposed(by: disposeBag)
        
        subscribeToCharcterSelection()
        
    }
    
    func setupTableView() {
        charctersTableView.register(UINib(nibName: "CharactersTableViewCell", bundle: nil), forCellReuseIdentifier: "CharactersTableViewCell")
    }
    
    func subscribeToResponse() {
        self.charctersViewModel.charctersModelObservable
            .bind(to: self.charctersTableView
                .rx
                .items(cellIdentifier: "CharactersTableViewCell",
                       cellType: CharactersTableViewCell.self)) { row, charcter, cell in
                cell.itemNameLabel.text = charcter.name
                
                let image = (charcter.thumbnail?.path ?? "") + "." + (charcter.thumbnail?.thumbnailExtension ?? "")
                cell.itemImage.sd_setImage(with: URL(string: image))
                cell.yearLabel.text = "modified : " + (charcter.modified ?? "")
                
            }.disposed(by: disposeBag)
    }
    
    func subscribeToLoading() {
        charctersViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    func subscribeToCharcterSelection() {
        Observable
            .zip(charctersTableView.rx.itemSelected, charctersTableView.rx.modelSelected(Resulting.self))
            .bind { [weak self] selectedIndex, charcter in
                
                let sb = UIStoryboard(name: "CharcterDetails", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "CharcterDetailsViewController") as! CharcterDetailsViewController
                
                vc.sharedViewModel = self?.sharedViewModel

                self?.navigateToDestination(selectedCharacter: charcter)
                self?.navigationController?.pushViewController(vc, animated: true)
                
            }.disposed(by: disposeBag)
    }
    
    func getcharcters() {
        charctersViewModel.getAllCharacter()
        
    }
    
    
}
