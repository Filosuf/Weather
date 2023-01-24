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

struct Location: Codable {
    let name: String
    let lat: String
    let lon: String
    let address: String
}

protocol StorageProtocol {
    var settings: Settings { get set }
    var firstRunCompleted: Bool { get set }

    func addLocation(_ location: Location)
    func getLocations() -> [Location]?
}

final class SettingsStorageService: StorageProtocol {

    // MARK: - Properties
    private let storage = UserDefaults.standard
    private let settingsKey = "settings"
    private let locationsKey = "locations"
    private let firstRunKey = "firstRun"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    var settings: Settings {
        get {
            getSettings() ?? Settings()
        }
        set {
            saveSettings(newValue)
        }
    }

    var firstRunCompleted: Bool {
        get {
            storage.bool(forKey: firstRunKey)
        }
        set {
            storage.set(newValue, forKey: firstRunKey)
        }
    }

    // MARK: - Methods
    func addLocation(_ location: Location) {
        var locations = getLocations() ?? [Location]()
        locations.append(location)
        if let encoded = try? encoder.encode(locations) {
            storage.set(encoded, forKey: locationsKey)
        }
    }

    func getLocations() -> [Location]? {
        if let data = storage.object(forKey: locationsKey) as? Data {
            if let locations = try? decoder.decode([Location].self, from: data) {
                return locations
            }
        }
        return nil
    }

    private func getSettings() -> Settings? {
        if let data = storage.object(forKey: settingsKey) as? Data {
            if let settings = try? decoder.decode(Settings.self, from: data) {
                return settings
            }
        }
        return nil
    }

    private func saveSettings(_ newValue: Settings) {
        if let encoded = try? encoder.encode(newValue) {
            storage.set(encoded, forKey: settingsKey)
        }
    }
}
