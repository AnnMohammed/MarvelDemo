//
//  Request.swift
//  Marvel
//
//  Created by Ann Mohamed on 02/02/2024.
//

import Foundation
import Alamofire

class URLs {
    static let Instance = URLs()
    private init() {}
    
    
    private let url = "https://gateway.marvel.com"
    
    public func getCharacters() -> String {
        return url + "/v1/public/characters?ts=1&apikey=ff15d8ef4fafc58be55d2c75d64eaa9b&hash=62e886e98c35dfc514a968619ebc0684"
    }
    
}
