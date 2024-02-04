//
//  CharcterDetailsViewController.swift
//  Marvel
//
//  Created by Ann Mohamed on 03/02/2024.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage


class CharcterDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var comicsView: UIView!
    @IBOutlet weak var seriesView: UIView!
    @IBOutlet weak var storiesView: UIView!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var relatedLinksTableView: UITableView!{
        didSet{
            relatedLinksTableView.register(UINib(nibName: "LinksTableViewCell", bundle: nil), forCellReuseIdentifier: "LinksTableViewCell")
            
            
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbNailPhoto: UIImageView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!{
        didSet{
            setCollectionView(collectionName: eventsCollectionView)
        }
    }
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!{
        didSet{
            setCollectionView(collectionName: storiesCollectionView)
        }
    }
    @IBOutlet weak var seriesCollectionView: UICollectionView!{
        didSet{
            setCollectionView(collectionName: seriesCollectionView)
        }
    }
    @IBOutlet weak var commicsCollectionView: UICollectionView!{
        didSet{
            setCollectionView(collectionName: commicsCollectionView)
        }
    }
    
    private let disposeBag = DisposeBag()
    var viewModel = CharcterDetailsViewModel()
    
    var sharedViewModel: SharedViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        suscribeToComicsImages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        //subscribeToComicsSelection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        relatedLinksTableView.layoutIfNeeded()
        tableViewHeight.constant = relatedLinksTableView.contentSize.height
    }
    
    func loadImage(from path: String) -> Observable<UIImage?> {
        guard let url = URL(string: path) else {
            return Observable.just(nil)
        }
        
        return Observable.create { observer in
            SDWebImageManager.shared.loadImage(
                with: url,
                options: [],
                progress: nil
            ) { image, _, _, _, _, _ in
                observer.onNext(image)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func setData() {
        sharedViewModel.selectedCharacter
            .map { $0?.name ?? "" }
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        sharedViewModel.selectedCharacter
            .map { $0?.description ?? "" }
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        setDataToImage()
//        subscribeToComics()
//        subscribeToSeries()
//        subscribeToEvents()
//        subscribeToStories()
//        subscribeToLinks()
        
    }
    
    func setDataToImage() {
        
        sharedViewModel.selectedCharacter
            .flatMap { selectedCharacter -> Observable<UIImage?> in
                guard let thumbnailPath = selectedCharacter?.thumbnail?.path,
                      let thumbnailExtension = selectedCharacter?.thumbnail?.thumbnailExtension else {
                    return Observable.just(nil)
                }
                
                let completeThumbnailPath = thumbnailPath + "." + thumbnailExtension
                return self.loadImage(from: completeThumbnailPath)
            }
            .bind(to: thumbNailPhoto.rx.image)
            .disposed(by: disposeBag)
        
    }
    
    func setCollectionView(collectionName: UICollectionView) {
        
        collectionName.delegate = self
        collectionName.dataSource = self

        collectionName.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
    }
}
