//
//  EntityProviderMock.swift
//  CoronaVirousRegulationsTests
//
//  Created by Amirreza Eghtedari on 8/21/1399 AP.
//

import Foundation
@testable import CoronaVirousRegulations

class EntityProviderMock: EntityProviderInterface {
	
	private let greenLow = Int.min
	private let greenHigh = 35
	
	private let yellowLow = 35
	private let yellowHigh = 50
	
	private let redLow = 50
	private let redHigh = Int.max
	
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
	
	static var threatLevels			= [ThreatLevel]()
	static var generalRegulations 	= [Regulation]()
	
	var greenLevel: ThreatLevel 	= .init(color: .green, lowerMargin: 0, upperMarging: 35)
	
	var yellowLevel: ThreatLevel 	= .init(color: .yellow, lowerMargin: 35, upperMarging: 50)
	
	var redLevel: ThreatLevel 		= .init(color: .red, lowerMargin: 50, upperMarging: 100)
	
	var threatLevels: [ThreatLevel] {
		get { Self.threatLevels }
	}
	
	var generalRegulations : [Regulation] {
		get { Self.generalRegulations }
	}
	
	var greenRegulations 	= [Regulation]()
	
	var yellowRegulations 	= [Regulation]()
	
	var redRegulations 		= [Regulation]()
	
	func getIncidentsInfo(incidentsNo: Int) -> IncidentsInfo {
		
		return IncidentsInfo(incidentsNo: 20, threatLevel: ThreatLevel.init(color: .green, lowerMargin: 0, upperMarging: 35), specialRegulations: [Regulation.alcoholConsumption10], generalRegulations: [Regulation.faceToFaceContactInPublicAreas])
	}
}
