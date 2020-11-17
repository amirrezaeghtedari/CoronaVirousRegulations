//
//  NetworkRequestLoader.swift
//  IDmelon
//
//  Created by Amirreza Eghtedari on 6/3/1399 AP.
//  Copyright © 1399 AP IDmelon. All rights reserved.
//

import Foundation

class NetworkLoader: NetworkLoaderInterface {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        
        self.urlSession 		= urlSession
    }
    
    typealias Response = (data: Data, modelID: String?)
    
    typealias Completion = (Result<Response, NetworkError>) -> Void
    
    func isInternetConnected() -> Bool{
        return InternetReachability.isConnected()
    }
    
    func loadRequest(request: URLRequest, modelID: String?, timeout: Double, completion: Completion?) {
        
        if !isInternetConnected() {
            
            completion?(Result.failure(NetworkError(
                                errorKind: .internetIsNotConnected,
                                modelID: nil)))
            return
        }
        
        urlSession.configuration.timeoutIntervalForRequest = timeout
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            self.completionHandler(data: data, response: response, error: error, completion: completion, modelID: modelID)
        }
        
        task.resume()
    }
    
    func completionHandler(data:Data?, response: URLResponse?, error: Error?, completion: Completion?, modelID: String?) {
        
        guard error == nil else {
            completion?(Result.failure(NetworkError(errorKind: .unableToComplete, modelID: modelID)))
            return
        }
        
        if let response = response as? HTTPURLResponse, response.statusCode != 200  {
            completion?(Result.failure(NetworkError(errorKind: .invalidResponse(response.statusCode), modelID: modelID)))
            return
        }
        
        guard let data = data else {
            completion?(Result.failure(NetworkError(errorKind: .invalidData(nil), modelID: modelID)))
            return
        }
        
        completion?(Result.success((data,modelID)))
    }
}
