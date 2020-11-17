//
//  LocationProviderMock.swift
//  CoronaVirousRegulationsTests
//
//  Created by Amirreza Eghtedari on 8/21/1399 AP.
//

import Foundation
@testable import CoronaVirousRegulations

class LocationProviderMock: LocationProviderInterface {
	
	var delegate: LocationProviderDelegate?
	
	static var coordinate: Coordinate?
	
	func requestCoordinate(locationIncidator: Bool) {
		
		if let coordinate = Self.coordinate {
			delegate?.locationProvider(self, didReceiveCoordinate: coordinate)
		} else {
			delegate?.locationProvider(self, didFailWithError: NSError(domain: "Failed to do so", code: 0, userInfo: nil))
		}
	}
}
