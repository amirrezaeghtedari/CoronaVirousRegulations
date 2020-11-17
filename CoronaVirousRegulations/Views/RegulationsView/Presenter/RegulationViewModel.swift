//
//  GeneralRegulationViewModel.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

struct RegulationViewModel: Hashable {

	let description: 	String
	let imageId: 		String
	
	init(regulation: Regulation) {

		self.description 	= NSLocalizedString(regulation.rawValue, comment: "")
		self.imageId 		= regulation.rawValue
	}
}
