//
//  APIProviderInterface.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/21/1399 AP.
//

import Foundation

protocol NetworkAPIProviderInterface {
	
	associatedtype RequestModel
	associatedtype ResponseModel: Codable
	
	func prepareURLRequest(request: RequestModel) throws -> URLRequest
	
	func parseResponse(data: Data) throws -> ResponseModel
}

extension NetworkAPIProviderInterface {
	
	func parseResponse(data: Data) throws -> ResponseModel {
		
		let decoder = JSONDecoder()
		let responseModel = try decoder.decode(ResponseModel.self, from: data)
		
		return responseModel
	}
}
