//
//  Conditions.swift
//  Weather
//
//  Created by Filosuf on 26.02.2023.
//

import Foundation

enum Conditions: String, CaseIterable {
    case clear
    case partlyCloudy = "partly-cloudy"
    case cloudy
    case overcast
    case drizzle
    case lightRain = "light-rain"
    case rain
    case moderateRain = "moderate-rain"
    case heavyRain = "heavy-rain"
    case continuousHeavyRain = "continuous-heavy-rain"
    case showers
    case wetSnow = "wet-snow"
    case lightSnow = "light-snow"
    case snow
    case snowShowers = "snow-showers"
    case hail
    case thunderstorm
    case thunderstormWithRain = "thunderstorm-with-rain"
    case thunderstormWithHail = "thunderstorm-with-hail"

    static func fetchCondition(with name: String?) -> Conditions {
        guard let name = name else {
            return Conditions.clear
        }
        let condition = Conditions.allCases.first { $0.rawValue == name }
        return condition ?? Conditions.clear
    }


    static func fetchTitle(with condition: Conditions) -> String {
        switch condition {
        case .clear:
            return "ясно"
        case .partlyCloudy:
            return "малооблачно"
        case .cloudy:
            return "облачно с прояснениями"
        case .overcast:
            return "пасмурно"
        case .drizzle:
            return "морось"
        case .lightRain:
            return "небольшой дождь"
        case .rain:
            return "дождь"
        case .moderateRain:
            return "умеренно сильный дождь"
        case .heavyRain:
            return "сильный дождь"
        case .continuousHeavyRain:
            return "длительный сильный дождь"
        case .showers:
            return "ливень"
        case .wetSnow:
            return "дождь со снегом"
        case .lightSnow:
            return "небольшой снег"
        case .snow:
            return "снег"
        case .snowShowers:
            return "снегопад"
        case .hail:
            return "град"
        case .thunderstorm:
            return "гроза"
        case .thunderstormWithRain:
            return "дождь с грозой"
        case .thunderstormWithHail:
            return "гроза с градом"
        }
    }

    static func fetchIconName(with condition: Conditions) -> String {
        switch condition {
        case .clear:
            return "sun"
        case .partlyCloudy:
            return "cloudsAndSun"
        case .cloudy:
            return "cloudsAndSun"
        case .overcast:
            return "clouds"
        case .drizzle, lightRain, rain, moderateRain, heavyRain, continuousHeavyRain, showers, wetSnow:
            return "rain"
        case .lightSnow, snow, snowShowers, hail:
            return "snow"
        case .thunderstorm:
            return "storm"
        case .thunderstormWithRain:
            return "storm"
        case .thunderstormWithHail:
            return "storm"
        }
    }
}
