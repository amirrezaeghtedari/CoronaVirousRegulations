//
//  LocationProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation
import CoreLocation

protocol LocationProviderInterface {
	
	var delegate: LocationProviderDelegate? { get set }
	
	func requestCoordinate(locationIncidator: Bool)
}
