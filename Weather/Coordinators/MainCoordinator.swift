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

//    func showPhotos() {
//        let vc = controllersFactory.makePhotoViewController()
//        navCon.pushViewController(vc, animated: true)
//    }
//
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
