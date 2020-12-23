//
//  LocationProviderDelegate.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/24/1399 AP.
//

import Foundation

protocol LocationProviderDelegate: class {
	
	func locationProvider(_ provider: LocationProviderInterface, didReceiveCoordinate coordinate: Coordinate)
	func locationProvider(_ provider: LocationProviderInterface, didFailWithError error: Error)
}
