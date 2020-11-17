//
//  ThreatStoreProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/24/1399 AP.
//

import Foundation

protocol ThreatColorStoreProviderInterface {
	
	func save(threatColor: ThreatColor)
	func threatColor() -> ThreatColor?
}
