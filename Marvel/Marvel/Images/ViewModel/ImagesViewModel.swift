//
//  ImagesViewModel.swift
//  Marvel
//
//  Created by Ann Mohamed on 04/02/2024.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class ImagesViewModel {
    
    var showAlert = PublishSubject<String>()
    
    private var imagesModelSubject = PublishSubject<[ImagesResult]>()
    
    var imagesModelObservable: Observable<[ImagesResult]> {
        return imagesModelSubject
    }
    
    func getAllImages(url: String) {
        NetworkCall.shared.getImages(url: url) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if data.code == 200 {
                    
                    guard let Charcters = data.data else { return }
                    self.imagesModelSubject.onNext(Charcters.results ?? [])
                    
                }else{
                    
                    self.showAlert.onNext(data.status ?? "")
                    
                }
            case .failure(let error):
                if let error = error as? MarvelError {
                    self.showAlert.onNext(error.message.rawValue)
                    print(error.message.rawValue)
                    
                }else{
                    self.showAlert.onNext((error as? ErrorModel)?.msg ?? "")
                    print((error as? ErrorModel)?.msg ?? "")
                }
            }
        }
    }
    
}


