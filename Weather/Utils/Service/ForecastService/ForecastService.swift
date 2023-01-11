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
    func fetchForecast(lat: String, lon: String) {
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)")
        ]
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.setValue("\(token)", forHTTPHeaderField: "X-Yandex-API-Key")

        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<ForecastResult, Error>) in
//            guard let self = self else { return }
            switch result {
            case .success(let model):
                for hour in model.forecasts[0].hours {
                    let timeResult = hour?.hourTs
                    let date = Date(timeIntervalSince1970: timeResult!)
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                    dateFormatter.timeZone = .current
                    let localDate = dateFormatter.string(from: date)
                    print(localDate)
                }
//                var nextPagePhotos: [Photo] = []
//                for model in models {
//                    let photo = Photo(photoResult: model)
//                    nextPagePhotos.append(photo)
//                }
//                DispatchQueue.main.async {
//                    self.photos += nextPagePhotos
//                    self.lastLoadedPage = nextPage
//                }
//                NotificationCenter.default
//                    .post(
//                        name: ImagesListService.didChangeNotification,
//                        object: self)
            case .failure:
                return
            }
        }
        task.resume()
    }

}
