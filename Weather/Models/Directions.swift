//
//  Wind.swift
//  Weather
//
//  Created by Filosuf on 28.02.2023.
//

import Foundation
enum Directions: String, CaseIterable {
    case nw
    case n
    case ne
    case e
    case se
    case s
    case sw
    case w
    case c
    case unowned

    static func fetchDirection(with name: String) -> Directions {
        let direction = Directions.allCases.first { $0.rawValue == name }
        return direction ?? Directions.unowned
    }

    static func fetchTitle(with direction: Directions) -> String {
        switch direction {
        case .nw:
            return "СЗ"
        case .n:
            return "С"
        case .ne:
            return "СВ"
        case .e:
            return "В"
        case .se:
            return "ЮВ"
        case .s:
            return "Ю"
        case .sw:
            return "ЮЗ"
        case .w:
            return "З"
        case .c:
            return "Штиль"
        case .unowned:
            return "-"
        }
    }
}
