//
//  BackgroundScheduler.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/22/1399 AP.
//

import Foundation
import BackgroundTasks
import os

class BackgroundScheduler {
	
	let backgroundTaskId = "com.amirrezaeghtedari.coronaVirousRegulations.incidents.fetch"
	
	static let shared = BackgroundScheduler()
	
	private var operation: BackgroundFetchOperation = {
		
		let locationProvider 			= LocationProvider()
		let incidentsAPIProvider 		= IncidentsAPIProvider()
		let networkLoader 				= NetworkLoader()
		let incidentsProvider 			= IncidentsProvider(apiProvider: incidentsAPIProvider, networkLoader: networkLoader)
		let entityProvider				= EntityProvider()
		let threatColorStoreProvider 	= ThreatColorStoreProvider()
		let localNotificationProvider   = LocalNotificationProvider()
		
		let operation = BackgroundFetchOperation(locationProvider: locationProvider, incidentsProvider: incidentsProvider, entityProvider: entityProvider, threatColorStoreProvider: threatColorStoreProvider, localNotificationProvider: localNotificationProvider)
		
		locationProvider.delegate 			= operation
		localNotificationProvider.delegate 	= operation
		
		return operation
	}()
	
	private init() {}
	
	func scheduleAppRefresh() {
		
		os_log("scheduleAppRefresh exetued.")
		
		let request = BGAppRefreshTaskRequest(identifier: backgroundTaskId)
		request.earliestBeginDate = Date(timeIntervalSinceNow: AppSettings.refreshInterval)

		do {
			try BGTaskScheduler.shared.submit(request)
		} catch {
			os_log("Could not schedule app refresh:", error.localizedDescription)
		}
	}
	
	func handleAppRefresh(task: BGAppRefreshTask) {
		
		os_log("handleAppRefresh exetued.")
		
		scheduleAppRefresh()
		
		operation.fetch() {success in
			os_log("backgroundFetch expiration called")
			task.setTaskCompleted(success: success)
		}
	}
}
