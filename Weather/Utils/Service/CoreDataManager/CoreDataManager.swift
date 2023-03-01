//
//  CoreDataManager.swift
//  Weather
//
//  Created by Filosuf on 11.01.2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func save(_ weather: ForecastResult, locationName: String)
}

final class CoreDataManager: CoreDataManagerProtocol {
    // MARK: - Properties
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    static let shared = CoreDataManager()

    // MARK: - Private Init
    private init() {}

    // MARK: - Methods
    func save(_ weather: ForecastResult, locationName: String) {
        persistentContainer.performBackgroundTask { [weak self] contextBackground in
            guard let self = self else { return }

            let newWeather = self.fetchWeather(locationName: locationName, context: contextBackground)
            newWeather.locationName = locationName
            newWeather.uploadTime = Double(weather.now)

            let newFact = self.createIndicators(entity: newWeather.fact, indicators: weather.fact, context: contextBackground)
            newWeather.fact = newFact

            let timeZone = newWeather.timeZone ?? TimeZoneInfo(context: contextBackground)
            timeZone.name = weather.info.tzinfo.name
            timeZone.offset = Int64(weather.info.tzinfo.offset)
            newWeather.timeZone = timeZone
            
            for forecast in weather.forecasts {
                let oldForecast = self.fetchForecast(locationName: newWeather.locationName, date: forecast.dateTs)
//                print(Date(timeIntervalSince1970: oldForecast?.date ?? 0))
//                print("search date = \(Date(timeIntervalSince1970: Double(forecast.dateTs)))")
                let newForecast =  oldForecast ?? Forecast(context: contextBackground)
                newForecast.locationName = locationName
                newForecast.date = Double(forecast.dateTs)
                newForecast.moonCode = Int16(forecast.moonCode)
                newForecast.sunset = forecast.sunset
                newForecast.sunrise = forecast.sunrise

                let newDayShort = self.createIndicators(entity: newForecast.dayShort, indicators: forecast.parts.dayShort, context: contextBackground)
                newForecast.dayShort = newDayShort

                let newNightShort = self.createIndicators(entity: newForecast.nightShort, indicators: forecast.parts.nightShort, context: contextBackground)
                newForecast.nightShort = newNightShort

                for hour in forecast.hours {
                    guard let hour = hour else { continue }
                    let oldHour = self.fetchHourForecast(forecast: newForecast, hour: hour.hourTs)
                    let newHour = self.createIndicators(entity: oldHour, indicators: hour, context: contextBackground)
                    newForecast.addToHours(newHour)
                }

                newWeather.addToForecasts(newForecast)
            }
            do {
                try contextBackground.save()
            } catch {
                print(error)
            }
        }
    }

    func getFact(locationName: String) -> Indicators? {
        let request = Weather.fetchRequest()
        request.predicate = NSPredicate(format: "locationName == %@", locationName)
        let fetchRequestResult = try? persistentContainer.viewContext.fetch(request)
        print("\(locationName).weather = \(fetchRequestResult?.count ?? -1)")
        return fetchRequestResult?.first?.fact
    }

    func getForecasts(locationName: String) -> [Forecast] {
        let date = Date().timeIntervalSince1970 - 86400
        let request = Forecast.fetchRequest()
        request.predicate = NSPredicate(format: "locationName == %@ AND date >= %@", locationName, date as NSNumber)
        guard var fetchRequestResult = try? persistentContainer.viewContext.fetch(request) else { return [] }
        fetchRequestResult.sort{ $0.date < $1.date }
        return fetchRequestResult
    }


    func getHourForecasts(locationName: String) -> [Indicators] {
        var hourForecasts = [Indicators]()
        let forecasts = getForecasts(locationName: locationName)
        let date = Date().timeIntervalSince1970 - 3600
        for forecast in forecasts {
            for hourForecast in forecast.hoursSorted {
                if hourForecasts.count >= 24 {
                    return hourForecasts
                }
                else if hourForecast.hourTs > date {
                    print(Date(timeIntervalSince1970: date))
                    print(Date(timeIntervalSince1970: hourForecast.hourTs))
                    hourForecasts.append(hourForecast)
                }
            }
        }
        return hourForecasts
    }

    func getTimeZone(locationName: String) -> TimeZoneInfo? {
        let request = Weather.fetchRequest()
        request.predicate = NSPredicate(format: "locationName == %@", locationName)
        let fetchRequestResult = try? persistentContainer.viewContext.fetch(request)
        return fetchRequestResult?.first?.timeZone
    }

//    func deleteObject(_ post: Post) {
//        let context = persistentContainer.viewContext
//
//        if let post = getPost(image: post.image, context: context) {
//            context.delete(post)
//            saveContext()
//        }
//    }
//
//    func deleteObject(_ post: PostDataModel) {
//        let context = persistentContainer.viewContext
//        context.delete(post)
//        saveContext()
//    }

//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    private func fetchForecast(locationName: String?, date: Int) -> Forecast? {
        guard let locationName = locationName else { return nil }

        let request = Forecast.fetchRequest()
        request.predicate = NSPredicate(format: "locationName == %@ AND date == %@", locationName, Double(date) as NSNumber)
        let fetchRequestResult = try? persistentContainer.viewContext.fetch(request)
        return fetchRequestResult?.first
    }

    func fetchHourForecast(forecast: Forecast, hour: Double?) -> Indicators? {
        guard let hour = hour else { return nil }

        for hourForecast in forecast.hoursSorted {
            if hourForecast.hourTs ==  hour {
                return hourForecast
            }
        }
        return nil
    }


    private func fetchWeather(locationName: String, context: NSManagedObjectContext) -> Weather {
        let request = Weather.fetchRequest()
        request.predicate = NSPredicate(format: "locationName == %@", locationName)
        let fetchRequestResult = try? persistentContainer.viewContext.fetch(request)
        return fetchRequestResult?.first ?? Weather(context: context)
    }

    private func createIndicators(entity: Indicators?, indicators: IndicatorsCodable, context: NSManagedObjectContext) -> Indicators {
        let newIndicators = entity ?? Indicators(context: context)
        newIndicators.temp = indicators.temp
        newIndicators.condition = indicators.condition
        newIndicators.feelsLike = indicators.feelsLike
        newIndicators.hour = indicators.hour
        newIndicators.hourTs = indicators.hourTs ?? 0
        newIndicators.precProb = Int16(indicators.precProb)
        newIndicators.tempMin = indicators.tempMin ?? 0
        newIndicators.uvIndex = Int16(indicators.uvIndex ?? 0)
        newIndicators.windDir = indicators.windDir
        newIndicators.windSpeed = indicators.windSpeed
        return newIndicators
    }
}

extension Forecast {
    var hoursSorted: [Indicators] {
        hours?.sortedArray(using: [NSSortDescriptor(key: "hourTs", ascending: true)]) as! [Indicators]
    }
}

extension Weather {
    var forecastsSorted: [Forecast] {
        forecasts?.sortedArray(using: [NSSortDescriptor(key: "date", ascending: true)]) as! [Forecast]
    }
}
