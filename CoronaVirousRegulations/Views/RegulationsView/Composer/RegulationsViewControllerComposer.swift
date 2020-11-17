//
//  RegulationsViewControllerComposer.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/19/1399 AP.
//

import Foundation

class RegulationsViewControllerComposer {
	
	func makeModule() -> RegulationsViewController {
		
		let entityProvider 				= EntityProvider()
		let networkLoader       		= NetworkLoader()
		let apiProvider         		= IncidentsAPIProvider()
		let incidentsProvider 			= IncidentsProvider(apiProvider: apiProvider, networkLoader: networkLoader)
		let locationProvider  			= LocationProvider()
		let threatColorStoreProvider 	= ThreatColorStoreProvider()
		
		let interactor 	= RegulationsInteractor(entityProvider: entityProvider, locationProvider: locationProvider, incidentsProvider: incidentsProvider, threatColorStorProvider: threatColorStoreProvider, backgroundFetchOperationType: BackgroundFetchOperation.self)
		
		locationProvider.delegate = interactor
		
		let presenter = RegulationsPresenter()
		
		let viewController = RegulationsViewController(interactor: interactor, alwaysLocationPermissionNotificationName: LocationProvider.alwaysLocationPermissionDidReceive)
		
		interactor.delegate	= presenter
		presenter.delegate	= viewController
		
		return viewController
	}
}
