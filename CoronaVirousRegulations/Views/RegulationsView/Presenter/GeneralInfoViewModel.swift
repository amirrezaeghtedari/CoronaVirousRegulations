//
//  GeneralInfoViewModel.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

struct GeneralInfoViewModel {
	
	let incidentsNo:			String
	let incidentsTextColor:		TextColorViewModel
	let incidentsBackColor:		ColorViewModel
	let threatLevels: 			[ThreatLevelViewModel]
	let generalSection:			RegulationSectionViewModel
	
	init(generalInfo: GeneralInfo) {
		
		self.incidentsNo 		= ""
		self.incidentsTextColor = .dark
		self.incidentsBackColor = .gray
		
		self.threatLevels		= generalInfo.threatLevels.map() { threatLevel in
			return ThreatLevelViewModel(level: threatLevel)
		}
		
		self.generalSection = RegulationSectionViewModel(generalRegulation: generalInfo.generalRegulations)
	}
}
