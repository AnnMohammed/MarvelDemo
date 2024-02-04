//
//  Request.swift
//  Marvel
//
//  Created by Ann Mohamed on 02/02/2024.
//

import UIKit
import Alamofire

class NetworkCall {
    static let shared = NetworkCall()
    private init() {}
    
    func getAllCharcters(callBack: @escaping (Result<CharctersModel, Error>) -> Void) {
        
        Request.request(url: URLs.Instance.getCharacters(), save: false, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, callBack: callBack)
    }
    
    func getImages(url: String,callBack: @escaping (Result<ImagesModel, Error>) -> Void) {
        
        let parameters = ["ts"        : "1",
                          "hash"              :"62e886e98c35dfc514a968619ebc0684",
                          "apikey"           :"ff15d8ef4fafc58be55d2c75d64eaa9b"
        ]
        
        Request.request(url: url, save: false, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, callBack: callBack)
    }
    
}


