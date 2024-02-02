//
//  md5.swift
//  Tadbeer
//
//  Created by Ann Mohamed on 26/01/2024.
//

import Foundation
import CryptoKit

class md5 {
    
    static let shared = md5()
    
    private init() {}
    
    let ts = String(Date().timeIntervalSince1970)


    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}


