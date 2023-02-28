//
//  TimeOfDayForecastView.swift
//  Weather
//
//  Created by Filosuf on 24.01.2023.
//

import Foundation
import UIKit

final class TimeOfDayForecastView: UIView {
    // MARK: - Properties
    private let timeOfDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var conditionImage: UIImageView = {
        let image = UIImageView()
        image.frame.size = CGSize(width: 26, height: 32)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let feelsLikeView = TimeOfDayIndicatorView()
    private let windView = TimeOfDayIndicatorView()
    private let uvIndex = TimeOfDayIndicatorView()
    private let probabilityOfPrecipitationView = TimeOfDayIndicatorView()

    private let indicatorsVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()

    private let headerHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.backgroundColor = .lightGray
        stackView.alignment = .center
        return stackView
    }()

    // MARK: - LifeCycle
    init() {
        super.init(frame: CGRect.zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func setupView(title: String, forecast: Indicators) {
        timeOfDayLabel.text = title
        let condition = Conditions.fetchCondition(with: forecast.condition ?? "")
        let conditionImageName = Conditions.fetchIconName(with: condition)
        let conditionTitle = Conditions.fetchTitle(with: condition)
        conditionImage.image = UIImage(named: conditionImageName)
        tempLabel.text = "\(Int(forecast.temp.rounded()))º"
        conditionLabel.text = conditionTitle
        let feelsLikeTemp = "\(forecast.feelsLike)º"
        let uvIndex = "\(forecast.uvIndex) UV"
        let windDirection = Directions.fetchDirection(with: forecast.description)
        let windDirectionLabel = Directions.fetchTitle(with: windDirection)
        let windSpeed = forecast.windSpeed
        let windTitle = "\(windSpeed)m/s \(windDirectionLabel)"
        let probabilityOfPrecipitation = "\(forecast.precProb)%"
        feelsLikeView.setIndicator(image: UIImage(named: "feelTemp")!, name: "По ощущениям", value: feelsLikeTemp)
        self.uvIndex.setIndicator(image: UIImage(named: "sun")!, name: "УФ индекс", value: uvIndex)
        windView.setIndicator(image: UIImage(named: "wind")!, name: "Ветер", value: windTitle)
        probabilityOfPrecipitationView.setIndicator(image: UIImage(named: "rainSecond")!, name: "Атмосферные осадки", value: probabilityOfPrecipitation)
    }

    private func layout() {
        let spaceInterval: CGFloat = 16

        [feelsLikeView,
         uvIndex,
         windView,
         probabilityOfPrecipitationView
        ].forEach { indicatorsVerticalStackView.addArrangedSubview($0)}

        [conditionImage,
         tempLabel
        ].forEach { headerHorizontalStackView.addArrangedSubview($0)}

        [timeOfDayLabel,
         headerHorizontalStackView,
         conditionLabel,
         indicatorsVerticalStackView
        ].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            feelsLikeView.heightAnchor.constraint(equalToConstant: 46),

            timeOfDayLabel.topAnchor.constraint(equalTo: topAnchor, constant: spaceInterval),
            timeOfDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),

            headerHorizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerHorizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: spaceInterval),
            headerHorizontalStackView.widthAnchor.constraint(equalToConstant: 72),
            headerHorizontalStackView.heightAnchor.constraint(equalToConstant: 37),


            conditionLabel.topAnchor.constraint(equalTo: headerHorizontalStackView.bottomAnchor, constant: spaceInterval),
            conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            indicatorsVerticalStackView.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: spaceInterval),
            indicatorsVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            indicatorsVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            indicatorsVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spaceInterval)
        ])

    }
}
