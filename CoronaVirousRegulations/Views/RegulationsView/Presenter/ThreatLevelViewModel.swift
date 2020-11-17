//
//  ThreatLevelViewModel.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

struct ThreatLevelViewModel {
	
	let levelColor: 	ColorViewModel
	let description: 	String
	let textColor: 		TextColorViewModel
	
	init(level: ThreatLevel) {
		
		switch level.color {
		
		case .green:
			self.levelColor 	= .green
			self.description 	= NSLocalizedString("Less than", comment: "") + " \(level.upperMarging)"
			self.textColor		= .dark
			
		case .yellow:
			self.levelColor 	= .yellow
			self.description 	= NSLocalizedString("More than", comment: "") + " \(level.lowerMargin)"
			self.textColor		= .dark
			
		case .red:
			self.levelColor 	= .red
			self.description 	= NSLocalizedString("More than", comment: "") + " \(level.lowerMargin)"
			self.textColor		= .dark
		}
	}
}
