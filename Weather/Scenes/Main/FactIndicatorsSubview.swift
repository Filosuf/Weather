//
//  FactIndicatorsSubview.swift
//  Weather
//
//  Created by Filosuf on 25.01.2023.
//

import Foundation
import UIKit

final class FactIndicatorsSubview: UIView {
    // MARK: - Properties
    lazy var conditionImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var windImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "moon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var rainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "moon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let conditionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        return view
    }()

    private let windView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()

    private let rainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
//        stackView.spacing = 10
//        stackView.backgroundColor = .lightGray
//        stackView.alignment = .center
        return stackView
    }()

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
    func setupView(condition: UIImage, wind: String, rain: String) {
        self.conditionImage.image = condition
        windLabel.text = wind
        rainLabel.text = rain
    }

    private func layout() {
        let interval:CGFloat = 5

        [conditionImage].forEach { conditionView.addSubview($0) }

        [windImage,
         windLabel
        ].forEach { windView.addSubview($0) }

        [rainImage,
         rainLabel
        ].forEach { rainView.addSubview($0) }


        [conditionView,
         windView,
         rainView
        ].forEach { horizontalStackView.addArrangedSubview($0)}

        [horizontalStackView].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            conditionImage.centerYAnchor.constraint(equalTo: conditionView.centerYAnchor),
            conditionImage.leadingAnchor.constraint(equalTo: conditionView.leadingAnchor),
            conditionImage.heightAnchor.constraint(equalToConstant: 18),
            conditionImage.widthAnchor.constraint(equalToConstant: 21),

            windImage.centerYAnchor.constraint(equalTo: windView.centerYAnchor),
            windImage.leadingAnchor.constraint(equalTo: windView.leadingAnchor),

            windLabel.centerYAnchor.constraint(equalTo: windView.centerYAnchor),
            windLabel.leadingAnchor.constraint(equalTo: windImage.trailingAnchor, constant:  interval),

            rainImage.centerYAnchor.constraint(equalTo: rainView.centerYAnchor),
            rainImage.leadingAnchor.constraint(equalTo: rainView.leadingAnchor),

            rainLabel.centerYAnchor.constraint(equalTo: rainView.centerYAnchor),
            rainLabel.leadingAnchor.constraint(equalTo: rainImage.trailingAnchor, constant: interval),
            rainLabel.trailingAnchor.constraint(equalTo: rainView.trailingAnchor),

            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
