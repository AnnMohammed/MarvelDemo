//
//  CharctersViewModel.swift
//  Marvel
//
//  Created by Ann Mohamed on 02/02/2024.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire


class CharctersViewModel {
    
    var showAlert = PublishSubject<String>()
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    
    
    private var charctersModelSubject = PublishSubject<[Resulting]>()
    
    var charctersModelObservable: Observable<[Resulting]> {
        return charctersModelSubject
    }
    
    func getAllCharacter() {
        NetworkCall.shared.getAllCharcters() { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if data.code == 200 {
                    
                    guard let Charcters = data.data else { return }
                    if Charcters.results?.count ?? 0 > 0 {
                        self.charctersModelSubject.onNext(Charcters.results ?? [])
                        self.isTableHidden.accept(false)
                    } else {
                        self.isTableHidden.accept(true)
                    }
                    
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
