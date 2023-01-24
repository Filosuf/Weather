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
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tempLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
            label.font = UIFont(name: "Rubik-Medium", size: 18)
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
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func setupCell() {
        dateLabel.text = "Date"
        timeLabel.text = "Time"
        tempLabel.text = "Tempº"
        feelsLikeView.setIndicator(image: UIImage(named: "moon")!, name: "По ощущению", value: "Valueº")
        conditionView.setIndicator(image: UIImage(named: "moon")!, name: "Value", value: "")
        windView.setIndicator(image: UIImage(named: "moon")!, name: "Ветер", value: "value")
        probabilityOfPrecipitationView.setIndicator(image: UIImage(named: "moon")!, name: "Атмосферные осадки", value: "value")
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
