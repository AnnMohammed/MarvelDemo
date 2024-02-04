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
    
    
    var selectedCharacterComics: [ComicsItem]?
    var selectedCharacterSerise: [ComicsItem]?
    var selectedCharacterStories: [StoriesItem]?
    var selectedCharacterEvents: [ComicsItem]?
    var thumnnailImage: String?
    var name: String?
    var descriptionData: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        subscribeToItems(collectionView: commicsCollectionView, items: selectedCharacterComics)
        subscribeToItems(collectionView: seriesCollectionView, items: selectedCharacterSerise)
        subscribeToItems(collectionView: eventsCollectionView, items: selectedCharacterEvents)
        subscribeToStories()
    }
    
    func setCollectionView(collectionName: UICollectionView) {
        
        collectionName.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
    }
    
    
    func subscribeToItems(collectionView: UICollectionView, items: [ComicsItem]?) {
            guard let items = items else {
                return
            }

            Observable.just(items)
                .bind(to: collectionView.rx.items(cellIdentifier: "ItemCollectionViewCell", cellType: ItemCollectionViewCell.self)) { row, character, cell in
                    cell.comicNameLabel.text = character.name
                }
                .disposed(by: disposeBag)
        }
    
    func subscribeToStories() {
            guard let selectedCharacterStories = selectedCharacterStories else {
                return
            }

            Observable.just(selectedCharacterStories)
                .bind(to: storiesCollectionView.rx.items(cellIdentifier: "ItemCollectionViewCell", cellType: ItemCollectionViewCell.self)) { row, character, cell in
                    cell.comicNameLabel.text = character.name
                }
                .disposed(by: disposeBag)
        }
    
    func setData(){
        
        thumbNailPhoto.sd_setImage(with: URL(string: thumnnailImage ?? ""))
        nameLabel.text = name
        descriptionLabel.text = descriptionData
    }
    
}
