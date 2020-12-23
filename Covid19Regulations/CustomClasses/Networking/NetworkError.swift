//
//  NetworkError.swift
//  IDmelon1
//
//  Created by Amirreza Eghtedari on 27.04.20.
//  Copyright © 2020 IDmelon. All rights reserved.
//

import Foundation

struct NetworkError: Error, LocalizedError {
    
    enum ErrorKind {
        case internetIsNotConnected
        case invalidUrl
        case unableToComplete
        case invalidRequest
        case invalidResponse(Int)
        case invalidData(Data?)
    }
    
    let errorKind: ErrorKind
    let modelID: String?
    
    var errorDescription: String? {
        switch errorKind  {
        case .internetIsNotConnected:
            return "There is no internet connection."
        case .invalidUrl:
            return "Invalid URL"
        case .unableToComplete:
            return "Unable to complete. Check network status."
        case .invalidRequest:
            return "Invalid Request"
        case let .invalidResponse(statusCode):
            return "Invalid Response. Status Code: \(statusCode)"
        case let .invalidData(data):
            if let data = data {
                return String.init(data: data, encoding: .utf8)
            } else {
                return "No data"
            }
        }
    }
}

