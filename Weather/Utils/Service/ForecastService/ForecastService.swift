//
//  ForecastService.swift
//  Weather
//
//  Created by Filosuf on 09.01.2023.
//

import Foundation

final class ForecastService {

    // MARK: - Properties
    private let baseUrl = forecastUrl
    private let token = forecastToken

    // MARK: - Methods
    func fetchForecast(lat: String, lon: String, completion: @escaping (Result<ForecastResult, Error>) -> Void) {
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)")
        ]
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.setValue("\(token)", forHTTPHeaderField: "X-Yandex-API-Key")

        let task = URLSession.shared.objectTask(for: request) { (result: Result<ForecastResult, Error>) in
            switch result {
            case .success(let forecast):
                completion(.success(forecast))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
