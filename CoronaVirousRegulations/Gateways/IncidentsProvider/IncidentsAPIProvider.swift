//
//  IncidentsAPIProvider.swift
//  CoronaVirousRegulations
//
//  Created by Amirreza Eghtedari on 8/21/1399 AP.
//

import Foundation

class IncidentsAPIProvider: NetworkAPIProviderInterface {
	
	typealias RequestModel 	= Coordinate
	typealias ResponseModel = IncidentsResponseModel
	
	func prepareURLRequest(request: Coordinate) throws -> URLRequest {
		
		let endPointString = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=cases7_per_100k&geometry=\(request.latitude),\(request.longitude),\(request.latitude),\(request.longitude)&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json"
		
		guard let url = URL(string: endPointString) else {
			
			throw(NetworkError(errorKind: NetworkError.ErrorKind.invalidRequest, modelID: nil))
		}
		
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "GET"
		
		return urlRequest
	}

}
