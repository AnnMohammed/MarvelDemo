//
//  SharedViewModel.swift
//  Marvel
//
//  Created by Ann Mohamed on 04/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

class SharedViewModel {
    
    var destinationUrl: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var selectedCharacter: BehaviorRelay<Resulting?> = BehaviorRelay(value: nil)
    
}
