//
//  IncidentsProviderMock.swift
//  CoronaVirousRegulationsTests
//
//  Created by Amirreza Eghtedari on 8/21/1399 AP.
//

import Foundation
@testable import CoronaVirousRegulations

class IncidentsProviderMock: IncidentsProviderInterface {
	
	static var result: Result<Int, Error>?
	
	func getIncidents(coordinate: Coordinate, completion: @escaping (Result<Int, Error>) -> Void) {
		
		guard let result = Self.result else { return }
		
		completion(result)
	}
}


