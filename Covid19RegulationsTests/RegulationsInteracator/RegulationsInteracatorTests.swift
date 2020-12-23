//
//  CoronaVirousRegulationsTests.swift
//  CoronaVirousRegulationsTests
//
//  Created by Amirreza Eghtedari on 8/17/1399 AP.
//

import XCTest
@testable import CoronaVirousRegulations

class RegulationsInteracatorTests: XCTestCase {
	
	//System Under Tests
	var sut: RegulationsInteractor!
    let delegate = RegulationsInteractorDelegateMock()
	
	override func setUpWithError() throws {
        
		let locationProvider = LocationProviderMock()
		
		sut = RegulationsInteractor(entityProvider: EntityProvider(),
							  locationProvider: locationProvider,
							  incidentsProvider: IncidentsProviderMock2(),
							  threatColorStorProvider: ThreatColorStoreProvider(),
							  backgroundFetchOperationType: BackgroundFetchOperation.self)
		sut.delegate = delegate
		locationProvider.delegate = sut
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func test_getGeneralInfo_Success() throws {
		
		let exp = expectation(description: "Expecting Results")
		
		EntityProviderMock.threatLevels = [ThreatLevel(color: .green, lowerMargin: 0, upperMarging: 35)]
		EntityProviderMock.generalRegulations = [.alcoholConsumption10, .alcoholConsumption9, .faceToFaceContactInPublicAreas]
		LocationProviderMock.coordinate = Coordinate(latitude: 9, longitude: 50)
		RegulationsInteractorDelegateMock.didGetGeneralInfo = { generalInfo in
			if (generalInfo.threatLevels.count != 0) && (generalInfo.generalRegulations.count != 0) {
				exp.fulfill()
			}
		}

		sut.getGeneralInfo()
	
		waitForExpectations(timeout: 5, handler: nil)
	}

    func test_getIncidentsInfo_success() throws {
        
		let exp = expectation(description: "Expecting Results")
		exp.expectedFulfillmentCount = 2
		
		LocationProviderMock.coordinate = Coordinate(latitude: 9, longitude: 50)
		IncidentsProviderMock2.result = Result.success(33)
		
		RegulationsInteractorDelegateMock.didStartGetRegulation = {
			exp.fulfill()
		}
		
		RegulationsInteractorDelegateMock.didGetIncidentsInfo = { result in
			if case Result.success(let incidentsInfo) = result {
				print(incidentsInfo.incidentsNo)
				if incidentsInfo.incidentsNo == 33 {
					exp.fulfill()
				}
			}
		}
		
		sut.getIncidentsInfo()
	
		waitForExpectations(timeout: 15, handler: nil)
    }

}
