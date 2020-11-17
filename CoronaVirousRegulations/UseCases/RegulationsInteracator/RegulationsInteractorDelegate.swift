//
//  RegulationsInteractorDelegate.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

protocol RegulationsInteractorDelegate {
	
	func interactorDidStartGetRegulations(_ interactor: RegulationsInteractorInterface)
	func interactorDidGet(_ interactor: RegulationsInteractorInterface, generalInfo: GeneralInfo)
	func interactorDidGet(_ interactor: RegulationsInteractorInterface, incidentsInfo: Result<IncidentsInfo, Error>)
}
