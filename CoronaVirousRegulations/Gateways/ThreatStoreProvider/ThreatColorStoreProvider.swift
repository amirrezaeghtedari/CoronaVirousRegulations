//
//  ThreatColorStoreProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/24/1399 AP.
//

import Foundation

class ThreatColorStoreProvider: ThreatColorStoreProviderInterface {
	
	let userDefaults = UserDefaults.standard
	let key 		= "484E9695-F48E-4B5A-B3CE-86CC26AFEB08"


	func save(threatColor: ThreatColor) {
		userDefaults.set(threatColor.rawValue, forKey: key)
	}
	
	func threatColor() -> ThreatColor? {
		
		guard  let savedThreatColor = userDefaults.value(forKey: key) as? String else {
			return nil
		}
		
		guard let threatColor = ThreatColor.init(rawValue: savedThreatColor) else {
			return nil
		}
		
		return threatColor
	}
	
}
