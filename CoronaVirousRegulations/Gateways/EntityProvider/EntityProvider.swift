//
//  EntityProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/18/1399 AP.
//

import Foundation

class EntityProvider: EntityProviderInterface {
	
	let greenLow = Int.min
	let greenHigh = 35
	
	let yellowLow = 35
	let yellowHigh = 50
	
	let redLow = 50
	let redHigh = Int.max
	
	var greenLevel: ThreatLevel {
		ThreatLevel(color: .green, lowerMargin: greenLow, upperMarging: greenHigh)
	}
	
	var yellowLevel: ThreatLevel {
		ThreatLevel(color: .yellow, lowerMargin: yellowLow, upperMarging: yellowHigh)
	}
	
	var redLevel: ThreatLevel{
		ThreatLevel(color: .red, lowerMargin: redLow, upperMarging: redHigh)
	}
	
	var threatLevels: [ThreatLevel] {
		
		[greenLevel, yellowLevel, redLevel]
	}
	
	var generalRegulations: [Regulation] {
		[.keepDistance, .wearMask, .washHands, .refreshRoom]
	}
	
	var greenRegulations: [Regulation] {
		[.faceToFaceContactInPublicAreas, .privateEvents100, .wearingMaskMandatory10]
	}
	
	var yellowRegulations: [Regulation] {
		[.privateEvents10, .wearingMaskMandatory9, .alcoholConsumption10]
	}
	
	var redRegulations: [Regulation] {
		[.privateEvents5, .wearingMaskMandatory8, .alcoholConsumption9]
	}
	
	func detectThreatLevel(incidentsNo: Int) -> ThreatLevel {
		
		switch incidentsNo {
		
		case greenLow..<greenHigh:
			return greenLevel
		
		case yellowLow..<yellowHigh:
			return yellowLevel
			
		case redLow...redHigh:
			return redLevel
			
		default:
			return redLevel
		}
	}
	
	func getIncidentsInfo(incidentsNo: Int) -> IncidentsInfo {
		
		let threatLevel = detectThreatLevel(incidentsNo: incidentsNo)
		
		switch threatLevel.color {
		
		case .green:
			return IncidentsInfo(incidentsNo: incidentsNo, threatLevel: threatLevel, specialRegulations: greenRegulations, generalRegulations: generalRegulations)
			
		case .yellow:
			return IncidentsInfo(incidentsNo: incidentsNo, threatLevel: threatLevel, specialRegulations: yellowRegulations, generalRegulations: generalRegulations)
		
		case.red:
			return IncidentsInfo(incidentsNo: incidentsNo, threatLevel: threatLevel, specialRegulations: redRegulations, generalRegulations: generalRegulations)
		}
	}
}
