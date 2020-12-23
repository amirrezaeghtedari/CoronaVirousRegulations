//
//  RegulationsPresenter.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

class RegulationsPresenter: RegulationsPresenterInterface {
	
	weak var delegate: RegulationsPresenterDelegate?
}

extension RegulationsPresenter: RegulationsInteractorDelegate {
	
	func interactorDidStartGetRegulations(_ interactor: RegulationsInteractorInterface) {
		
		delegate?.presenterDidStartGetRegulations(self)
	}
	
	func interactorDidGet(_ interactor: RegulationsInteractorInterface, generalInfo: GeneralInfo) {
		
		let generalInfoViewModel = GeneralInfoViewModel(generalInfo: generalInfo)
		delegate?.presenterDidGet(self, generalInfo: generalInfoViewModel)
	}
	
	func interactorDidGet(_ interactor: RegulationsInteractorInterface, incidentsInfo: Result<IncidentsInfo, Error>) {
		
		switch incidentsInfo {
		
		case Result.failure(let error):
			delegate?.presenterDidGet(self, incidentsInfo: Result.failure(error))
			
		case Result.success(let incidentsInfo):
			
			let incidntstNo = String(incidentsInfo.incidentsNo)
			
			let incidentsTextColor: TextColorViewModel
			let incidentsBackColor: ColorViewModel
			
			switch incidentsInfo.threatLevel.color {
			
			case .green:
				incidentsTextColor 	= .dark
				incidentsBackColor 	= .green
				
			case .yellow:
				incidentsTextColor 	= .dark
				incidentsBackColor 	= .yellow
				
			case .red:
				incidentsTextColor 	= .dark
				incidentsBackColor 	= .red
			}
			
			let specificRegulationSection = RegulationSectionViewModel(threatLevel: incidentsInfo.threatLevel, regulations: incidentsInfo.specialRegulations)
			
			let generalRegualationSection = RegulationSectionViewModel(generalRegulation: incidentsInfo.generalRegulations)
			
			let sections = [specificRegulationSection, generalRegualationSection]
			
			let incidentsViewModel = IncidentsViewModel(incidentsNo: incidntstNo,
									   incidentsTextColor: incidentsTextColor,
									   incidentsBackColor: incidentsBackColor,
									   regulationSections: sections)
			
			delegate?.presenterDidGet(self, incidentsInfo: Result.success(incidentsViewModel))
		}
		
	}
	
}
