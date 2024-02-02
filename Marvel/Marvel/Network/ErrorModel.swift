//
//  Request.swift
//  Marvel
//
//  Created by Ann Mohamed on 02/02/2024.
//

import Foundation

struct MarvelError: Error {
    var statusCode  : Int
    var message     : ErrorMessage
    
    init(statusCode: Int, message: ErrorMessage) {
        self.statusCode = statusCode
        self.message    = message
    }
}

enum ErrorMessage: String {
    case decodingError = "The Response From The Server Was In Invalid Format"
    case serverError = "There Was An Error In Server, Please Try Again Later!"
}


struct ErrorModel: Codable, Error {
    var msg: String?
    var success: Bool?
    var statusCode: Int?
    var payload: Payload?
}

// MARK: - Payload
struct Payload: Codable {
    var error: String?
}


struct GeneralModel: Codable {
    var msg: String?
    var statusCode: Int?
    var success: Bool?
}
