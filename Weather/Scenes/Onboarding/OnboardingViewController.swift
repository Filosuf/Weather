//
//  OnboardingViewController.swift
//  Weather
//
//  Created by Filosuf on 05.01.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - Properties
    let coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    private var storageService: StorageProtocol

    private let image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onboarding")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Разрешить приложению  Weather использовать данные о местоположении вашего устройства"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let annotationLabel: UILabel = {
        let label = UILabel()
        label.text = """
                     Чтобы получить более точные прогнозы погоды во время движения или путешествия

                     Вы можете изменить свой выбор в любое время из меню приложения
                     """
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .Settings.orange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(agreeButtonTap), for: .touchUpInside)
        return button
    }()

    private let notAgreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .Settings.orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(notAgreeButtonTap), for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle
    init(storageService: StorageProtocol) {
        self.storageService = storageService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .Custom.blue
        view.backgroundColor = .darkGray
//        GeocodingService().fetchLocations(for: "Москва") { _ in }
//        ForecastService().fetchForecast(lat: "61.07006", lon: "42.09830") { [weak self] result in
//            switch result {
//            case .success(let forecast):
//                self?.coreDataManager.save(forecast, locationName: "Moscow")
//            case .failure(_):
//                return
//            }
//        }
//        let weatherMoscow = coreDataManager.getForecast(locationName: "Moscow")
//        print(weatherMoscow?.locationName)
//        print(weatherMoscow?.fact?.feelsLike)
        layout()
    }

    // MARK: - Methods

    @objc private func agreeButtonTap() {
        print("Согласен")
    }

    @objc private func notAgreeButtonTap() {
        print("Не согласен")
        self.storageService.firstRunCompleted = true
        navigationController?.popViewController(animated: true)
    }

    private func layout() {

        [
         notAgreeButton
        ].forEach { view.addSubview($0)}

        NSLayoutConstraint.activate([
            notAgreeButton.heightAnchor.constraint(equalToConstant: 330),
            notAgreeButton.widthAnchor.constraint(equalToConstant: 320),
            notAgreeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notAgreeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
