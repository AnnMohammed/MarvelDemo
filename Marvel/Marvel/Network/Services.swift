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
    
}


