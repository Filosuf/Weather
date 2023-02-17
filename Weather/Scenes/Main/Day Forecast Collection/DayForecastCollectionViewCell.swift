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
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 18)
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
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tempLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
            label.font = UIFont(name: "Rubik-Regular", size: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(date: String) {
        dateLabel.text = date
        conditionImage.image = UIImage(named: "moon")
        probabilityOfPrecipitationLabel.text = "57%"
        conditionLabel.text = "Cloud"
        tempLabel.text = "4º - 11º"
    }

    private func layout() {
        let interval: CGFloat = 5
        [dateLabel].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: interval),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: interval),

            conditionImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: interval),
            conditionImage.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),

            probabilityOfPrecipitationLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            probabilityOfPrecipitationLabel.centerYAnchor.constraint(equalTo: conditionImage.centerYAnchor),

            conditionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            conditionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: interval),

            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -interval),

            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -interval)
        ])
    }
}
