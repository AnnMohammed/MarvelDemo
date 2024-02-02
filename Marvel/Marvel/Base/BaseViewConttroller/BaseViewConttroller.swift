//
//  BaseViewConttroller.swift
//  Marvel
//
//  Created by Ann Mohamed on 02/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewConttroller: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
    }
    
    func bind() {}
    
}
