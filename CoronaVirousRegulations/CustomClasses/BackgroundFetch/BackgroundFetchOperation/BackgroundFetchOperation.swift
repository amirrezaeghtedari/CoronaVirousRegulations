//
//  BackgroundFetchOperation.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/22/1399 AP.
//

import Foundation
import UserNotifications
import os

class BackgroundFetchOperation: BackgroundFetchOperationInterface {
	
	static let incidentsChangeNotification 	= Notification.Name("com.ammirrezaeghtedari.coronaVirousRegulations.incidentsNumberChanged")
	static var incidentsNoKey: String 		= "incidentNo"
	
	let locationRrovider:			LocationProvider
	let incidentsProvider: 			IncidentsProviderInterface
	let threatColorStoreProvider: 	ThreatColorStoreProviderInterface
	let entityProvider:				EntityProviderInterface
	let localNotificationProvider: 	LocalNotificationProviderInterface
	
	typealias Completion = (Bool) -> Void
	
	var completion: Completion?
	
	init(locationProvider: LocationProvider, incidentsProvider: IncidentsProviderInterface, entityProvider: EntityProviderInterface, threatColorStoreProvider: ThreatColorStoreProviderInterface, localNotificationProvider: LocalNotificationProviderInterface) {
	
		self.locationRrovider  			= locationProvider
		self.incidentsProvider			= incidentsProvider
		self.entityProvider				= entityProvider
		self.threatColorStoreProvider	= threatColorStoreProvider
		self.localNotificationProvider	= localNotificationProvider
	}
	
	deinit {
		os_log("Background fetch deinitialized")
	}
	
	func fetch(completion: @escaping Completion) {

		self.completion = completion
		locationRrovider.requestCoordinate(locationIncidator: true)
	}
	
	private func process(incidentsNo: Int) {
		
		let recentThreatColor 	= entityProvider.detectThreatLevel(incidentsNo: incidentsNo).color
		let lastThreatColor 	= threatColorStoreProvider.threatColor()
		
		if recentThreatColor != lastThreatColor {
			
			os_log("Background fetch send local notificaiton")
			
			//Send updates to the UI observers
			let userInfo = [Self.incidentsNoKey: incidentsNo]
			NotificationCenter.default.post(name: Self.incidentsChangeNotification, object: nil, userInfo: userInfo)
			
			//Send local notification
			localNotificationProvider.sendNotification()
		}
	}
}

extension BackgroundFetchOperation: LocationProviderDelegate {
	
	func locationProvider(_ provider: LocationProviderInterface, didReceiveCoordinate coordinate: Coordinate) {
		
		os_log("BackgroundFetch get coordinate: %f, %f", coordinate.latitude, coordinate.longitude)
		
		self.incidentsProvider.getIncidents(coordinate: coordinate) {result in

			switch result {

			case .failure(let error):
				os_log("BackgroundFetch failed to get number of incidents, error: %@", error.localizedDescription)
				
				self.localNotificationProvider.sendNotification()
				self.completion?(false)

			case .success(let incidentsNo):
				os_log("BackgroundFetch did get incidents %d", incidentsNo)
				
				self.process(incidentsNo: incidentsNo)
				self.completion?(true)
			}
		}
	}
	
	func locationProvider(_ provider: LocationProviderInterface, didFailWithError error: Error) {
		
		self.completion?(false)
	}
}

extension BackgroundFetchOperation: LocalNotificationProviderDelegate {
	
	func providerDidReceive(_ provider: LocalNotificationProviderInterface, incidentsNo: Int) {
		
		//Nothing to do
	}
}
