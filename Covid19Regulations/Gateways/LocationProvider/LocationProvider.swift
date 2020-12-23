//
//  LocationProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/19/1399 AP.
//

import Foundation
import CoreLocation

class LocationProvider: NSObject, LocationProviderInterface {
	
	static let alwaysLocationPermissionDidReceive = Notification.Name("com.amirrezaeghtedari.coronaVirousRegulation.alwayLocationPermissionDidReceive")
	
	var locationManager: CLLocationManager!
	
	weak var delegate: LocationProviderDelegate?
	
	override init() {
		
		super.init()
		
		DispatchQueue.main.async {[weak self] in
			
			guard let self = self else { return }
			
			self.locationManager = CLLocationManager()
			self.locationManager.requestWhenInUseAuthorization()
			self.locationManager.allowsBackgroundLocationUpdates = true
			self.locationManager.delegate = self
		}
	}
	
	func requestCoordinate(locationIncidator: Bool){
		
		DispatchQueue.main.async { [weak self] in
			
			self?.locationManager?.showsBackgroundLocationIndicator = locationIncidator
			self?.locationManager?.requestLocation()
		}
	}
}

extension LocationProvider: CLLocationManagerDelegate {
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		
		if manager.authorizationStatus != .notDetermined {
			
			manager.requestAlwaysAuthorization()
		}
		
		if manager.authorizationStatus == .authorizedAlways {
			
			NotificationCenter.default.post(name: Self.alwaysLocationPermissionDidReceive, object: nil)
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		manager.showsBackgroundLocationIndicator = false
		manager.stopUpdatingLocation()
		
		let location = locations.first!
		let coordinate = Coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		
		DispatchQueue.main.async { [weak self] in
			
			guard let self = self else { return }
			
			self.delegate?.locationProvider(self, didReceiveCoordinate: coordinate)
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		
		DispatchQueue.main.async { [weak self] in
			
			guard let self = self else { return }
			
			self.delegate?.locationProvider(self, didFailWithError: error)
		}
	}
}


