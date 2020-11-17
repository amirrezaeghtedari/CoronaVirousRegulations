//
//  IncidentsProviderComposer.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/24/1399 AP.
//

import Foundation

class IncidentsProviderComposer {
	
	static func makeModule() -> IncidentsProvider<IncidentsAPIProvider> {
		
		let apiProvider = IncidentsAPIProvider()
		let networkLoader = NetworkLoader()
		
		return IncidentsProvider(apiProvider: apiProvider, networkLoader: networkLoader)
	}
}
