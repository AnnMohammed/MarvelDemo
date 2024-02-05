//
//  ImagesViewController.swift
//  Marvel
//
//  Created by Ann Mohamed on 04/02/2024.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage


class ImagesViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!{
        didSet{
            setCollectionView()
        }
    }
    
    var url: String?
    
    let disposeBag = DisposeBag()
    
    let imagesViewModel = ImagesViewModel()
    
    let sharedViewModel = SharedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        subscribeToResponse()
    }
    
    
    func setCollectionView() {
        
        imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesCollectionViewCell")
        
    }
    
    func getData() {
        imagesViewModel.getAllImages(url: url ?? "")
    }
    
    func subscribeToResponse() {
        imagesViewModel.imagesModelObservable
            .bind(to: imagesCollectionView.rx.items(
                cellIdentifier: "ImagesCollectionViewCell",
                cellType: ImagesCollectionViewCell.self
            )) { [weak self] row, character, cell in
                if let image = character.images?[row] {
                    let imagePath = image.path ?? ""
                    let imageExtension = image.thumbnailExtension ?? ""
                    let fullImage = imagePath + "." + imageExtension
                    print(fullImage)
                    
                    if let imageURL = URL(string: fullImage) {
                        cell.image.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImage"), options: [], context: nil)
                    } else {
                        // Handle invalid URL case or show placeholder if needed
                        cell.image.image = UIImage(named: "marvel")
                    }
                } else {
                    // Handle nil character or image case or show placeholder if needed
                    cell.image.image = UIImage(named: "marvel")
                }
            }
            .disposed(by: disposeBag)
        
        imagesCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    
}
