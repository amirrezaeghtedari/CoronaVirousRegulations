//
//  IncidentsProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/19/1399 AP.
//

import Foundation

class IncidentsProviderMock<T>: IncidentsProviderInterface where T: NetworkAPIProviderInterface, T.RequestModel == Coordinate, T.ResponseModel == IncidentsResponseModel {
	
	let apiProvider: T
	let networkLoader: NetworkLoaderInterface
	
	var counter: Int = 1
	
	init(apiProvider: T, networkLoader: NetworkLoaderInterface) {
		
		self.apiProvider = apiProvider
		self.networkLoader = networkLoader
	}
	
	func getIncidents(coordinate: Coordinate, completion: @escaping (Result<Int, Error>) -> Void) {
		
		switch counter {
		case 0:
			completion(Result.success(28))
			counter += 1
		case 1:
			completion(Result.success(43))
			counter += 1
		case 2:
			completion(Result.success(79))
			counter += 1
		case 3:
			completion(Result.success(128))
			counter = 0
		default:
			completion(Result.success(-1))
		}
		
		
	}
}
