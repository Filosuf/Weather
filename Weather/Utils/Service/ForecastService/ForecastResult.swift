//
//  ForecastResult.swift
//  Weather
//
//  Created by Filosuf on 09.01.2023.
//

import Foundation

struct ForecastResult: Codable {
    let now: Int
    let nowDt: String
    let fact: IndicatorsCodable
    let forecasts: [ForecastCodable]

    enum CodingKeys: String, CodingKey {
        case now
        case nowDt = "now_dt"
        case fact, forecasts
    }
}

// MARK: - Fact
struct IndicatorsCodable: Codable {
    let temp, feelsLike: Double
    let condition: String
    let precProb: Int
    let windSpeed: Double
    let windDir: String
    let uvIndex: Int?
    let hour: String?
    let hourTs: Double?
    let tempMin: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
        case precProb = "prec_prob"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case uvIndex = "uv_index"
        case hour
        case hourTs = "hour_ts"
        case tempMin = "temp_min"
    }
}

// MARK: - Forecast
struct ForecastCodable: Codable {
    let date: String
    let dateTs: Int
    let sunrise, sunset: String?
    let moonCode: Int
    let parts: Parts
    let hours: [IndicatorsCodable?]

    enum CodingKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case sunrise, sunset
        case moonCode = "moon_code"
        case parts, hours
    }
}

// MARK: - Parts
struct Parts: Codable {
    let nightShort, dayShort: IndicatorsCodable

    enum CodingKeys: String, CodingKey {
        case nightShort = "night_short"
        case dayShort = "day_short"
    }
}
