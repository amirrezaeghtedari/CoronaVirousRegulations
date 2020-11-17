//
//  LocalNotificationProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/24/1399 AP.
//

import Foundation
import UserNotifications

class LocalNotificationProvider: NSObject, LocalNotificationProviderInterface {
	
	let identifier = "com.amirrezaeghtedari.com.coronaVirousRegulations.localNotification"
	
	weak var delegate: LocalNotificationProviderDelegate?
	
	override init() {
		
		super.init()
		
		UNUserNotificationCenter.current().delegate = self
	}
	
	func sendNotification() {
		
		let content 		= UNMutableNotificationContent()
		content.title 		= NSLocalizedString("localNotificationTitle", comment: "")
		content.body		= NSLocalizedString("localNotificationBody", comment: "")
		content.sound 		= .default
		
		let catergory  	= UNNotificationCategory(identifier: "ThreatLevelRegulations", actions: [], intentIdentifiers: [], options: [])
		UNUserNotificationCenter.current().setNotificationCategories([catergory])
		
		let request 	= UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
		UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
	}
}

extension LocalNotificationProvider: UNUserNotificationCenterDelegate {
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		
		switch response.actionIdentifier {
		
		case "com.apple.UNNotificationDefaultActionIdentifier":
			let userInfo = response.notification.request.content.userInfo
			guard let incidentsNo = userInfo["incidentsNo"] as? Int else { return }
			delegate?.providerDidReceive(self, incidentsNo: incidentsNo)
		
		default:
			break
		}
		
		completionHandler()
	}
}
