//
//  EntityProviderTests.swift
//  CoronaVirousRegulationsTests
//
//  Created by Amirreza Eghtedari on 8/24/1399 AP.
//

import XCTest
@testable import CoronaVirousRegulations

class EntityProviderTests: XCTestCase {

	var sut: EntityProvider!
	
    override func setUpWithError() throws {
        
		sut = EntityProvider()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_detectThreatLevel_success() throws {
		
		XCTAssert(sut.detectThreatLevel(incidentsNo: -10).color == .green)
		XCTAssert(sut.detectThreatLevel(incidentsNo: sut.greenLow).color  == .green)
		XCTAssert(sut.detectThreatLevel(incidentsNo: sut.greenHigh - 1).color == .green)
		
		XCTAssert(sut.detectThreatLevel(incidentsNo: sut.yellowLow).color == .yellow)
		XCTAssert(sut.detectThreatLevel(incidentsNo: sut.yellowHigh - 1).color == .yellow)
		
		XCTAssert(sut.detectThreatLevel(incidentsNo: sut.redLow).color == .red)
		XCTAssert(sut.detectThreatLevel(incidentsNo: sut.redHigh - 1).color == .red)
		
		XCTAssert(sut.detectThreatLevel(incidentsNo: sut.darkRedHigh).color == .darkRed)
		XCTAssert(sut.detectThreatLevel(incidentsNo: Int.max).color == .darkRed)
	}
}
