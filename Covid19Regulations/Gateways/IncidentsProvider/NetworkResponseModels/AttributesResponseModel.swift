//
//  AttributesResponseModel.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/21/1399 AP.
//

import Foundation

struct AttributesResponseModel: Codable {
	let cases7Per100K: Double?

	enum CodingKeys: String, CodingKey {
		case cases7Per100K = "cases7_per_100k"
	}
}
