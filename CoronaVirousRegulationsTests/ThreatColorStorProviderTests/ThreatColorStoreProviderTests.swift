//
//  ThreatColorStoreProviderTests.swift
//  CoronaVirousRegulationsTests
//
//  Created by Amirreza Eghtedari on 8/24/1399 AP.
//

import XCTest
@testable import CoronaVirousRegulations

class ThreatColorStoreProviderTests: XCTestCase {

	var sut: ThreatColorStoreProvider!
    
	override func setUpWithError() throws {
        sut = ThreatColorStoreProvider()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_saveGet_success() throws {
		
		UserDefaults.standard.removeObject(forKey: sut.key)
		XCTAssertNil(UserDefaults.standard.value(forKey: sut.key))
		
		sut.save(threatColor: ThreatColor.red)
		let savedThreatColor = sut.threatColor()
		XCTAssert(savedThreatColor == ThreatColor.red)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
