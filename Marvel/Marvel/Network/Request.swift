//
//  Request.swift
//  Marvel
//
//  Created by Ann Mohamed on 02/02/2024.
//

import Foundation
import Alamofire

class Request {
    class func request<T: Codable>(url: String,save: Bool,  method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding , headers: HTTPHeaders?,
                                   callBack:@escaping (Result<T, Error>) -> Void) {
        
        let jsonDecodeer = JSONDecoder()
        
        print(url)
        URLCache.shared.removeAllCachedResponses()
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseDecodable(of: T.self) { (response) in
            
            print(response.result)
            print(response)
            switch response.result {
            case .success:
                if let _ = response.data {
                    guard let resultData = response.data else { fatalError() }
                    do {
                        if save {
                            print("userSaved")
                        }
                        let basicResponse = try jsonDecodeer.decode(T.self, from: resultData)
                        print(basicResponse)
                        callBack(.success(basicResponse))
                    }
                    catch(let error) {
                        print(error)
                        let requestError = MarvelError(statusCode: 200, message: .decodingError)
                        callBack(.failure(requestError))
                    }
                }
            case .failure(let error):
                if (error.responseCode ?? 800) < 500 {
                    guard let resultData = response.data else { fatalError() }
                    do {
                        let basicResponse = try jsonDecodeer.decode(ErrorModel.self, from: resultData)
                        print(basicResponse)
                        callBack(.failure(basicResponse))
                    }
                    catch(let error) {
                        print(error)
                        print(error.localizedDescription)
                        
                        let requestError = MarvelError(statusCode: 200, message: .decodingError)
                        callBack(.failure(requestError))
                    }
                }else{
                    print(error)
                    print(error.localizedDescription)
                    print(error.isResponseSerializationError)
                    let requestError = MarvelError(statusCode: response.response?.statusCode ?? 800, message: .serverError)
                    callBack(.failure(requestError))
                }
            }
        }
    }
}
