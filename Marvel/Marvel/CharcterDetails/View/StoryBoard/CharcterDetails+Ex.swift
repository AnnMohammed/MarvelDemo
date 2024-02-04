//
//  CharcterDetails+Ex.swift
//  Marvel
//
//  Created by Ann Mohamed on 04/02/2024.
//

import Foundation
import UIKit

extension CharcterDetailsViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == commicsCollectionView {
            
            return sharedViewModel.selectedCharacter.value?.comics?.items?.count ?? 0
            
        }else if collectionView == seriesCollectionView{
            return sharedViewModel.selectedCharacter.value?.series?.items?.count ?? 0
        }else if collectionView == storiesCollectionView{
            return sharedViewModel.selectedCharacter.value?.stories?.items?.count ?? 0
        }else{
            return sharedViewModel.selectedCharacter.value?.events?.items?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let base = sharedViewModel.selectedCharacter.value
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
        
        if collectionView == commicsCollectionView{
            cell.comicNameLabel.text = base?.comics?.items?[indexPath.row].name
        }else if collectionView == seriesCollectionView {
            cell.comicNameLabel.text = base?.series?.items?[indexPath.row].name
        }else if collectionView == storiesCollectionView {
            cell.comicNameLabel.text = base?.stories?.items?[indexPath.row].name
        }else{
            cell.comicNameLabel.text = base?.events?.items?[indexPath.row].name
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let base = sharedViewModel.selectedCharacter.value
        let sb = UIStoryboard(name: "Images", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ImagesViewController") as! ImagesViewController
        
        if collectionView == commicsCollectionView{
            vc.url = base?.comics?.items?[indexPath.row].resourceURI
        }else if collectionView == seriesCollectionView {
            vc.url = base?.series?.items?[indexPath.row].resourceURI
        }else if collectionView == storiesCollectionView {
            vc.url = base?.stories?.items?[indexPath.row].resourceURI
        }else{
            vc.url = base?.events?.items?[indexPath.row].resourceURI
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == commicsCollectionView {
            return CGSize(width: commicsCollectionView.frame.size.width / 3 , height: 180)
        }else  if collectionView == seriesCollectionView {
            return CGSize(width: seriesCollectionView.frame.size.width / 3 , height: 180)
        }else  if collectionView == storiesCollectionView {
            return CGSize(width: storiesCollectionView.frame.size.width / 3 , height: 180)
        }else{
            return CGSize(width: eventsCollectionView.frame.size.width / 3 , height: 180)
        }
        
    }
    
}
