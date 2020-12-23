//
//  LocationProviderMock.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/27/1399 AP.
//

import Foundation

class LocationProviderMock: LocationProviderInterface {
	
	var delegate: LocationProviderDelegate?
	
	func requestCoordinate(locationIncidator: Bool) {
		
		let coordinate = Coordinate(latitude: 9, longitude: 50)
		delegate?.locationProvider(self, didReceiveCoordinate: coordinate)
	}
	
}
