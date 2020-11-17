//
//  SectionType.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/20/1399 AP.
//

import Foundation

struct RegulationSectionViewModel {
	
	let title: String
	let color: ColorViewModel
	let regulations: [RegulationViewModel]
	
	init(threatLevel: ThreatLevel, regulations: [Regulation]) {
		
		self.regulations = regulations.map() { regulation in
			return RegulationViewModel(regulation: regulation)
		}
		
		switch threatLevel.color {
		
		case .green:
			self.color = .green
			self.title = NSLocalizedString("Green Regulations", comment: "")
			
		case .yellow:
			self.color = .yellow
			self.title = NSLocalizedString("Yellow Regulations", comment: "")
			
		case .red:
			self.color = .red
			self.title = NSLocalizedString("Red Regulations", comment: "")
		}
	}
	
	init(generalRegulation regulations: [Regulation]) {
		
		self.regulations = regulations.map() { regulation in
			return RegulationViewModel(regulation: regulation)
		}
		
		self.color = .gray
		self.title = NSLocalizedString("General Regulations", comment: "")
	}
}

extension RegulationSectionViewModel: Hashable {
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(title)
	}
}
