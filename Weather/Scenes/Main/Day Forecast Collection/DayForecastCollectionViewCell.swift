//
//  DayForecastCollectionViewCell.swift
//  Weather
//
//  Created by Filosuf on 26.01.2023.
//

import UIKit

final class DayForecastCollectionViewCell: UICollectionViewCell {
    static let identifier = "DayForecastCollectionViewCell"

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Text.textSecond
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let conditionImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let probabilityOfPrecipitationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Main.blueSecond
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Text.text
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        settingCell()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func settingCell() {
        backgroundColor = .Main.backgroundDayCell
        layer.cornerRadius = 5
    }

    func setupCell(date: String) {
        dateLabel.text = date
        conditionImage.image = UIImage(named: "moon")
        probabilityOfPrecipitationLabel.text = "57%"
        conditionLabel.text = "Cloud"
        tempLabel.text = "4º - 11º"
    }

    private func layout() {
        let interval: CGFloat = 10
        [dateLabel,
         conditionImage,
         probabilityOfPrecipitationLabel,
         conditionLabel,
         tempLabel,
         arrowImage
        ].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: interval),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),

            conditionImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
            conditionImage.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),

            probabilityOfPrecipitationLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            probabilityOfPrecipitationLabel.centerYAnchor.constraint(equalTo: conditionImage.centerYAnchor),
            probabilityOfPrecipitationLabel.heightAnchor.constraint(equalToConstant: 16),

            conditionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            conditionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: interval),
            conditionLabel.heightAnchor.constraint(equalToConstant: 20),

            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -interval),
            tempLabel.heightAnchor.constraint(equalToConstant: 23),

            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -interval)
        ])
    }
}
