//
//  RegulationsPresenterDelegate.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

protocol RegulationsPresenterDelegate: class {
	
	func presenterDidStartGetRegulations(_ presenter: RegulationsPresenterInterface)
	
	func presenterDidGet(_ presenter: RegulationsPresenterInterface, generalInfo: GeneralInfoViewModel)
	
	func presenterDidGet(_ presenter: RegulationsPresenterInterface, incidentsInfo: Result<IncidentsViewModel, Error>)
}
