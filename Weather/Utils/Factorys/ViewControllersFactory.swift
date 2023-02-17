//
//  ViewControllersFactory.swift
//  Weather
//
//  Created by Filosuf on 16.01.2023.
//

import Foundation

final class ViewControllersFactory {

//    var userService: UserService {
//        #if DEBUG
//            return TestUserService()
//        #else
//            return CurrentUserService()
//        #endif
//    }
    // MARK: - Properties
    private let storageService = SettingsStorageService()

    // MARK: - Methods
    func makeMainViewController(coordinator: MainCoordinator) -> MainViewController {
        let viewController = MainViewController(storageService: storageService, coordinator: coordinator)
        return viewController
    }

    func makeOnboardingViewController() -> OnboardingViewController {
        let viewController = OnboardingViewController(storageService: storageService)
        return viewController
    }

    func makeSettingsViewController() -> SettingsViewController {
        let viewController = SettingsViewController(storageService: storageService)
        return viewController
    }

    func makeAddLocationViewController(coordinator: MainCoordinator) -> AddLocationViewController {
        let viewController = AddLocationViewController(coordinator: coordinator)
        return viewController
    }

//    func makeHourlyForecastViewController(coordinator: MainCoordinator) -> HourlyForecastViewController {
//        let viewController = HourlyForecastViewController(coordinator: coordinator)
//        return viewController
//    }

}
