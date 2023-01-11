//
//  CoordinatesResult.swift
//  Weather
//
//  Created by Filosuf on 09.01.2023.
//

import Foundation

struct CoordinatesResult: Decodable {

    let response: Response

    // MARK: - Response
    struct Response: Codable {
        let geoObjectCollection: GeoObjectCollection

        enum CodingKeys: String, CodingKey {
            case geoObjectCollection = "GeoObjectCollection"
        }
    }

    // MARK: - GeoObjectCollection
    struct GeoObjectCollection: Codable {
        let featureMember: [FeatureMember]
    }

    // MARK: - FeatureMember
    struct FeatureMember: Codable {
        let geoObject: GeoObject

        enum CodingKeys: String, CodingKey {
            case geoObject = "GeoObject"
        }
    }

    // MARK: - GeoObject
    struct GeoObject: Codable {
        let name, description: String?
        let point: Point

        enum CodingKeys: String, CodingKey {
            case name, description
            case point = "Point"
        }
    }

    // MARK: - Point
    struct Point: Codable {
        let pos: String
    }
}
