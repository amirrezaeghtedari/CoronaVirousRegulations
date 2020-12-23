//
//  RegulationsInteractor.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

class RegulationsInteractor: RegulationsInteractorInterface {
	
	let entityProvider:				EntityProviderInterface
	let locationProvider: 			LocationProviderInterface
	let incidentsProvider: 			IncidentsProviderInterface
	let threatColorStorProvider:	ThreatColorStoreProviderInterface
	
	let backgroundFetchOperationType: BackgroundFetchOperationInterface.Type
	
	var delegate: RegulationsInteractorDelegate?
	
	var currentThreatLeve: ThreatLevel?
	
	init(entityProvider: EntityProviderInterface,
		 locationProvider: LocationProviderInterface,
		 incidentsProvider: IncidentsProviderInterface,
		 threatColorStorProvider: ThreatColorStoreProviderInterface,
		 backgroundFetchOperationType: BackgroundFetchOperationInterface.Type) {
		
		self.entityProvider				= entityProvider
		self.incidentsProvider 			= incidentsProvider
		self.locationProvider 			= locationProvider
		self.threatColorStorProvider 	= threatColorStorProvider
		
		self.backgroundFetchOperationType = backgroundFetchOperationType
		
		observeIncidentsNoBackgroundFetch()
	}
	
	var incidentsBackgroundFetch: Int = 0
	
	private func observeIncidentsNoBackgroundFetch() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleIncidentsBackgroundFetch(notification:)), name: backgroundFetchOperationType.incidentsChangeNotification, object: nil)
	}
	
	@objc
	func handleIncidentsBackgroundFetch(notification: Notification) {
		
		guard let userInfo = notification.userInfo else { return }
		guard let incidentsNo = userInfo[backgroundFetchOperationType.incidentsNoKey] as? Int else { return }
		
		process(incidentsNo: incidentsNo)
	}
	
	func getGeneralInfo() {
		
		let generalInfo = GeneralInfo(threatLevels: entityProvider.threatLevels, generalRegulations: entityProvider.generalRegulations)
		
		delegate?.interactorDidGet(self, generalInfo: generalInfo)
	}
	
	private func fetchIncidetntInfo(coordinate: Coordinate) {
		
		incidentsProvider.getIncidents(coordinate: coordinate) {[weak self] result in
			
			guard let self = self else { return }
			
			switch result {
			case .failure(let error):
				self.process(incidentsError: error)
				
			case .success(let incidentsNo):
				self.process(incidentsNo: incidentsNo)
			}
		}
	}
	
	private func process(incidentsError: Error) {
		
		self.delegate?.interactorDidGet(self, incidentsInfo: Result.failure(incidentsError))
	}
	
	private func process(incidentsNo: Int) {
		
		let incidentsInfo = self.entityProvider.getIncidentsInfo(incidentsNo: incidentsNo)
		self.currentThreatLeve = incidentsInfo.threatLevel
		self.delegate?.interactorDidGet(self, incidentsInfo: Result.success(incidentsInfo))
	}
	
	var continuesGetIncidentsInfo = false
	
	func getIncidentsInfo() {

		delegate?.interactorDidStartGetRegulations(self)
		
		self.locationProvider.requestCoordinate(locationIncidator: false)
		
		if !continuesGetIncidentsInfo {
			
			continuesGetIncidentsInfo = true
			
			DispatchQueue.global(qos: .background).async {[weak self] in
				
				Timer.scheduledTimer(withTimeInterval: AppSettings.refreshInterval, repeats: true) { _ in

					self?.locationProvider.requestCoordinate(locationIncidator: false)
				}

				RunLoop.current.run()
			}
		}
		
	}
	
	func saveCurrentThreatColor() {
		
		if let currentThreatLeve = self.currentThreatLeve {
			threatColorStorProvider.save(threatColor: currentThreatLeve.color)
		}
	}
}

extension RegulationsInteractor: LocationProviderDelegate {
	
	func locationProvider(_ provider: LocationProviderInterface, didReceiveCoordinate coordinate: Coordinate) {
		
		fetchIncidetntInfo(coordinate: coordinate)
	}
	
	func locationProvider(_ provider: LocationProviderInterface, didFailWithError error: Error) {
		
		//Nothing to do
	}

}
