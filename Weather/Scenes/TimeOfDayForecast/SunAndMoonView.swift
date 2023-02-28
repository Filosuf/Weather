//
//  SunAndMoonView.swift
//  Weather
//
//  Created by Filosuf on 24.01.2023.
//

import Foundation
import UIKit

final class SunAndMoonView: UIView {
    // MARK: - Properties
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Солнце и Луна"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let sunImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sun")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()


    let daylightHoursLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let sunriseNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Восход"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let sunriseValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let sunsetNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Заход"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let sunsetValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let moonImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "moon")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()

    private let moonLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

//    private let dividerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    // MARK: - LifeCycle
    init() {
        super.init(frame: CGRect.zero)
        layout()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func setIndicator(daylight: String, sunrise: String, sunset: String, moonPhase: String) {
        daylightHoursLabel.text = daylight
        sunriseValueLabel.text = sunrise
        sunsetValueLabel.text = sunset
        moonLabel.text = moonPhase
    }

    private func layout() {
        let interval: CGFloat = 16

        [headerLabel,
         sunImage,
         daylightHoursLabel,
         sunriseNameLabel,
         sunriseValueLabel,
         sunsetNameLabel,
         sunsetValueLabel,
         moonImage,
         moonLabel
        ].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),

            sunImage.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: interval),
            sunImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: interval),

            daylightHoursLabel.topAnchor.constraint(equalTo: sunImage.topAnchor),
            daylightHoursLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -interval),

            sunriseNameLabel.topAnchor.constraint(equalTo: sunImage.bottomAnchor, constant: interval),
            sunriseNameLabel.leadingAnchor.constraint(equalTo: sunImage.leadingAnchor),

            sunriseValueLabel.topAnchor.constraint(equalTo: sunriseNameLabel.topAnchor),
            sunriseValueLabel.trailingAnchor.constraint(equalTo: daylightHoursLabel.trailingAnchor),

            sunsetNameLabel.topAnchor.constraint(equalTo: sunriseNameLabel.bottomAnchor, constant: interval),
            sunsetNameLabel.leadingAnchor.constraint(equalTo: sunImage.leadingAnchor),

            sunsetValueLabel.topAnchor.constraint(equalTo: sunsetNameLabel.topAnchor),
            sunsetValueLabel.trailingAnchor.constraint(equalTo: daylightHoursLabel.trailingAnchor),

            moonImage.topAnchor.constraint(equalTo: sunsetNameLabel.bottomAnchor, constant: interval),
            moonImage.leadingAnchor.constraint(equalTo: sunImage.leadingAnchor),

            moonLabel.topAnchor.constraint(equalTo: moonImage.topAnchor),
            moonLabel.trailingAnchor.constraint(equalTo: daylightHoursLabel.trailingAnchor),
        ])
    }
}
