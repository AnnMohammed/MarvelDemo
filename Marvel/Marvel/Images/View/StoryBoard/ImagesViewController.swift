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
        
        // Do any additional setup after loading the view.
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
        self.imagesViewModel.imagesModelObservable
            .bind(to: self.imagesCollectionView
                .rx
                .items(cellIdentifier: "ImagesCollectionViewCell",
                       cellType: ImagesCollectionViewCell.self)) { row, charcter, cell in
                
                let imagePath = charcter.images?[row].path
                let imageEX = charcter.images?[row].thumbnailExtension
                
                let fullImage = (imagePath ?? "") + "." + (imageEX ?? "")
                print(fullImage)
                cell.image.sd_setImage(with: URL(string: fullImage))
                
            }.disposed(by: disposeBag)
        
        imagesCollectionView.rx.setDelegate(self)
                   .disposed(by: disposeBag)
        
    }
    
}
