//
//  NetworkLoader.swift
//  IDmelon
//
//  Created by Amirreza Eghtedari on 6/5/1399 AP.
//  Copyright © 1399 AP IDmelon. All rights reserved.
//

import Foundation

protocol NetworkLoaderInterface {
	
	typealias Response = (data: Data, modelID: String?)
	
	typealias Completion = (Result<Response, NetworkError>) -> Void
	
	func loadRequest(request: URLRequest, modelID: String?, timeout: Double, completion: Completion?)
}

	
