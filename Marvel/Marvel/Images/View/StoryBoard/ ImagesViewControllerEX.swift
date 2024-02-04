//
//   ImagesViewControllerEX.swift
//  Marvel
//
//  Created by Ann Mohamed on 04/02/2024.
//

import Foundation
import UIKit

extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imagesCollectionView.frame.size.width , height: imagesCollectionView.frame.size.height )
        
    }
    
}
