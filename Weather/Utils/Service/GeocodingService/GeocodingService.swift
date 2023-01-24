//
//  GeocodingService.swift
//  Weather
//
//  Created by Filosuf on 09.01.2023.
//

import Foundation

final class GeocodingService {
    // MARK: - Properties
    private let baseUrl = geocodingUrl
    private let token = geocodingToken
    private var task: URLSessionTask?
    private var lastName: String?

    // MARK: - Methods
    func fetchLocations(for name: String, completion: @escaping (Result<[Location], Error>) -> Void) {
        guard name != "" else { return }
        
        if lastName == name { return }
        task?.cancel()
        lastName = name

        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: "\(token)"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "results", value: "10"),
            URLQueryItem(name: "geocode", value: "\(name)"),
        ]
        let url = urlComponents.url!
        let request = URLRequest(url: url)

        let task = URLSession.shared.objectTask(for: request) {(result: Result<CoordinatesResult, Error>) in
            switch result {
            case .success(let model):
                var locations = [Location]()
                let locationsResponse = model.response.geoObjectCollection.featureMember
                for locationsResponse in locationsResponse {
                    let name = locationsResponse.geoObject.name ?? name
                    let coordinates = locationsResponse.geoObject.point.pos.split(separator: " ")
                    let lon = String(coordinates[0])
                    let lat = String(coordinates[1])
                    let address = locationsResponse.geoObject.metaDataProperty?.geocoderMetaData?.text ?? "Empty"

                    let location = Location(name: name, lat: lat, lon: lon, address: address)
                    locations.append(location)
                }

                completion(.success(locations))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        self.task = task
        task.resume()
    }
}
