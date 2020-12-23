//
//  IncidentsProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/19/1399 AP.
//

import Foundation
import os

class IncidentsProvider<T>: IncidentsProviderInterface where T: NetworkAPIProviderInterface, T.RequestModel == Coordinate, T.ResponseModel == IncidentsResponseModel {
	
	let apiProvider: T
	let networkLoader: NetworkLoaderInterface
	
	init(apiProvider: T, networkLoader: NetworkLoaderInterface) {
		
		self.apiProvider = apiProvider
		self.networkLoader = networkLoader
	}
	
	deinit {
		os_log("IncidentsProvider deinitialized")
	}
	
	func getIncidents(coordinate: Coordinate, completion: @escaping (Result<Int, Error>) -> Void) {
		
		guard let urlRequest = try? apiProvider.prepareURLRequest(request: coordinate) else {
			
			completion(Result.failure(NetworkError(errorKind: .invalidRequest, modelID: nil)))
			return
		}
		
		networkLoader.loadRequest(request: urlRequest, modelID: nil, timeout: 9) { result in
			
			switch result {
			
			case .success(let successResult):
			
				do {
					
					let response = try self.apiProvider.parseResponse(data: successResult.data)
					
					if response.features?.count ?? 0 > 0 {
						if let cases7Per100k = response.features?[0].attributes?.cases7Per100K {
							completion(Result.success(Int(cases7Per100k)))
						}
					} else {
						completion(Result.failure(NetworkError(errorKind: .invalidData(successResult.data), modelID: nil)))
					}
				} catch {
					completion(Result.failure(NetworkError(errorKind: .invalidData(successResult.data), modelID: nil)))
				}
				
			case .failure(let networkError):
				
				completion(Result.failure(networkError))
			}
		}
	}
}
