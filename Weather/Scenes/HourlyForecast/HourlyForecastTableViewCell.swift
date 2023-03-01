//
//  HourlyForecastTableViewCell.swift
//  Weather
//
//  Created by Filosuf on 23.01.2023.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "HourlyForecastTableViewCell"

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Text.text
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Text.textSecond
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Text.text
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let feelsLikeView = HourlyForecastIndicatorView()
    private let conditionView = HourlyForecastIndicatorView()
    private let windView = HourlyForecastIndicatorView()
    private let probabilityOfPrecipitationView = HourlyForecastIndicatorView()

    private let indicatorsVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .Main.backgroundCell
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func setupCell(forecast: HourForecastViewModel) {
        dateLabel.text = forecast.date
        timeLabel.text = forecast.time
        tempLabel.text = forecast.temp
        feelsLikeView.setIndicator(image: UIImage(named: "feelTemp"), name: "По ощущению", value: forecast.feelTemp)
        conditionView.setIndicator(image: forecast.conditionImage, name: forecast.conditionTitle, value: "")
        windView.setIndicator(image: UIImage(named: "wind"), name: "Ветер", value: forecast.wind)
        probabilityOfPrecipitationView.setIndicator(image: UIImage(named: "rainSecond"),
                                                    name: "Атмосферные осадки",
                                                    value: forecast.probabilityOfPrecipitation)
    }

    private func layout() {
        let spaceInterval: CGFloat = 16

        [feelsLikeView,
         conditionView,
         windView,
         probabilityOfPrecipitationView
        ].forEach { indicatorsVerticalStackView.addArrangedSubview($0)}

        [dateLabel,
         timeLabel,
         tempLabel,
         indicatorsVerticalStackView
        ].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            feelsLikeView.heightAnchor.constraint(equalToConstant: 19),

            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spaceInterval),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spaceInterval),

            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: spaceInterval),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spaceInterval),

            tempLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: spaceInterval),
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spaceInterval),

            indicatorsVerticalStackView.topAnchor.constraint(equalTo: timeLabel.topAnchor),
            indicatorsVerticalStackView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: spaceInterval),
            indicatorsVerticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spaceInterval),
            indicatorsVerticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spaceInterval)
        ])

    }

}
