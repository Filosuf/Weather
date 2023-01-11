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

    // MARK: - Methods
    func fetchCoordinates(for name: String, completion: @escaping (Result<String, Error>) -> Void) {
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: "\(token)"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "results", value: "1"),
            URLQueryItem(name: "geocode", value: "\(name)"),
        ]
        let url = urlComponents.url!
        let request = URLRequest(url: url)

        let task = URLSession.shared.objectTask(for: request) {(result: Result<CoordinatesResult, Error>) in
            switch result {
            case .success(let model):
                let coordinates = model.response.geoObjectCollection.featureMember[0].geoObject.point.pos
                completion(.success(coordinates))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
