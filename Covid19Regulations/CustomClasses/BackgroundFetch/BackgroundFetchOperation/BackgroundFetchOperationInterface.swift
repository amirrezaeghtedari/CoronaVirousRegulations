//
//  BackgroundFetchOperationInterface.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/25/1399 AP.
//

import Foundation

protocol BackgroundFetchOperationInterface {
	
	static var incidentsChangeNotification: Notification.Name { get }
	static var incidentsNoKey: String { get }
}
