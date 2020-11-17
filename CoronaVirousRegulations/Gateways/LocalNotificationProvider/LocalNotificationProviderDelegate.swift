//
//  LocalNotificationProviderDelegate.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/24/1399 AP.
//

import Foundation

protocol LocalNotificationProviderDelegate: class {
	
	func providerDidReceive(_ provider: LocalNotificationProviderInterface, incidentsNo: Int)
}
