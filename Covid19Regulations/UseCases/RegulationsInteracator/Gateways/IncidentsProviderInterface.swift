//
//  IncidentsProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

protocol IncidentsProviderInterface {
	
	func getIncidents(coordinate: Coordinate, completion: @escaping (Result<Int, Error>) -> Void)
}
