//
//  EntityProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

protocol EntityProviderInterface {
	
	var greenLevel: 	ThreatLevel { get }
	var yellowLevel: 	ThreatLevel { get }
	var redLevel: 		ThreatLevel { get }
	
	var threatLevels: 	[ThreatLevel] { get }
	
	var generalRegulations: [Regulation] { get }
	
	var greenRegulations: 	[Regulation] { get }
	var yellowRegulations: 	[Regulation] { get }
	var redRegulations: 	[Regulation] { get }
	
	func detectThreatLevel(incidentsNo: Int) -> ThreatLevel
	func getIncidentsInfo(incidentsNo: Int) -> IncidentsInfo
}
