//
//  paddingTextField.swift
//  Eventia
//
//  Created by khaled omar on 2/6/20.
//  Copyright © 2020 khaled omar. All rights reserved.
//
//
//import UIKit
//
//class paddingTextField: UITextField {
//
//   let padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 5)
//
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//}
//
//extension UITextField {
//     func setAlignment(lang: Languages) {
//        if lang == .ar{
//            self.textAlignment = .right
//        }else{
//            self.textAlignment = .left
//        }
//    }
//}
