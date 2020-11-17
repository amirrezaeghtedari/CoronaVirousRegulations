//
//  RegulationsInfo.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

struct IncidentsInfo {
	
	let incidentsNo: Int
	let threatLevel: ThreatLevel
	let specialRegulations: [Regulation]
	let generalRegulations: [Regulation]
}
