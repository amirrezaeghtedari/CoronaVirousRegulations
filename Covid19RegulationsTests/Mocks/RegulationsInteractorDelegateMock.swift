//
//  RegulationsInteractorDelegate.swift
//  CoronaVirousRegulationsTests
//
//  Created by Amirreza Eghtedari on 8/21/1399 AP.
//

import Foundation
@testable import CoronaVirousRegulations

class RegulationsInteractorDelegateMock: RegulationsInteractorDelegate {
	
	static var didStartGetRegulation: (() -> Void)?
	static var didGetGeneralInfo: ((GeneralInfo) -> Void)?
	static var didGetIncidentsInfo: ((Result<IncidentsInfo, Error>) -> Void)?
	
	func interactorDidStartGetRegulations(_ interactor: RegulationsInteractorInterface) {
		
		Self.didStartGetRegulation?()
	}
	
	func interactorDidGet(_ interactor: RegulationsInteractorInterface, generalInfo: GeneralInfo) {
		Self.didGetGeneralInfo?(generalInfo)
	}
	
	func interactorDidGet(_ interactor: RegulationsInteractorInterface, incidentsInfo: Result<IncidentsInfo, Error>) {
		Self.didGetIncidentsInfo?(incidentsInfo)
	}
}
