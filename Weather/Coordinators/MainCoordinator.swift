//
//  MainCoordinator.swift
//  Weather
//
//  Created by Filosuf on 16.01.2023.
//

import UIKit

final class MainCoordinator {

    private let controllersFactory: ViewControllersFactory
    let navCon: UINavigationController

    //MARK: - Initialiser
    init(navCon: UINavigationController, controllersFactory: ViewControllersFactory) {
        self.controllersFactory = controllersFactory
        self.navCon = navCon
    }

    func showOnboarding() {
        let onboardingVC = controllersFactory.makeOnboardingViewController()
        navCon.pushViewController(onboardingVC, animated: false)
    }

    func showAddLocation() {
        let addLocationVC = controllersFactory.makeAddLocationViewController(coordinator: self)
        navCon.pushViewController(addLocationVC, animated: true)
    }

    func showSettings() {
        let settingsVC = controllersFactory.makeSettingsViewController(coordinator: self)
        navCon.pushViewController(settingsVC, animated: true)
    }

    func showTimeOfDayForecast(index forecastSelected: Int, in forecasts: [Forecast], timeZone: TimeZoneInfo?) {
        let timeOfDayVC = controllersFactory.makeTimeOfDayForecastViewController(index: forecastSelected, in: forecasts, timeZone: timeZone)
        navCon.pushViewController(timeOfDayVC, animated: true)
    }


    func showHourlyForecast(forecasts: [Indicators], timeZone: TimeZoneInfo?) {
        let hourlyVC = controllersFactory.makeHourlyForecastViewController(forecasts: forecasts, timeZone: timeZone)
        navCon.pushViewController(hourlyVC, animated: true)
    }

//    func showAlert(title: String, message: String, buttonText: String = "Ok") {
//        // создаём объекты всплывающего окна
//        let alert = UIAlertController(
//            title: title, // заголовок всплывающего окна
//            message: message, // текст во всплывающем окне
//            preferredStyle: .alert) // preferredStyle может быть .alert или .actionSheet
//
//        // создаём для него кнопки с действиями
//        let action = UIAlertAction(title: buttonText, style: .default)
//
//        // добавляем в алерт кнопки
//        alert.addAction(action)
//
//        // показываем всплывающее окно
//        navCon.present(alert, animated: true, completion: nil)
//    }

    func pop() {
        navCon.popViewController(animated: true)
    }
}
