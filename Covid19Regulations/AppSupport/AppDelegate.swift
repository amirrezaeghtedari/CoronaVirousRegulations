//
//  AppDelegate.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/17/1399 AP.
//

import UIKit
import BackgroundTasks
import os

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		BGTaskScheduler.shared.register(forTaskWithIdentifier: BackgroundScheduler.shared.backgroundTaskId, using: nil) { task in
			
			BackgroundScheduler.shared.handleAppRefresh(task: task as! BGAppRefreshTask)
		}

		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
}

