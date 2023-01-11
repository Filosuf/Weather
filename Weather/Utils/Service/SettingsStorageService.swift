//
//  SettingsStorageService.swift
//  Weather
//
//  Created by Filosuf on 04.01.2023.
//

import Foundation

struct Settings: Codable {
    var temperatureIsF = false
    var windSpeedIsKm = true
    var timeFormatIs24 = true
    var notificationsIsOn = true
}

final class SettingsStorageService {

    // MARK: - Properties
    private let storage = UserDefaults.standard
    private let key = "settings"

    var settings: Settings {
        get {
            getSettings() ?? Settings()
        }
        set {
            saveSettings(newValue)
        }
    }

    // MARK: - Methods
    private func getSettings() -> Settings? {
        if let data = storage.object(forKey: key) as? Data {
            if let settings = try? JSONDecoder().decode(Settings.self, from: data) {
                return settings
            }
        }
        return nil
    }

    private func saveSettings(_ newValue: Settings) {
        if let encoded = try? JSONEncoder().encode(newValue) {
            storage.set(encoded, forKey: key)
        }
    }
}
