//
//  OverviewSlideView.swift
//  Weather
//
//  Created by Filosuf on 18.01.2023.
//

import UIKit

final class OverviewSlideView: UIView {

    //MARK: - Properties
//    private let locationName: String
    var hourDetailAction: (() -> Void)?

    private let factView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var hourForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let dayForecastLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Ежедневный прогноз"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let hourForecastDetailButton: UIButton = {
        let button = UIButton()
        let attributedText = NSAttributedString(
            string: "Подробнее на 24 часа",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
        )
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hourForecastDetailButtonTap), for: .touchUpInside)
        return button
    }()

    private lazy var dayForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(DayForecastCollectionViewCell.self, forCellWithReuseIdentifier: DayForecastCollectionViewCell.identifier)
        return collectionView
    }()

    //MARK: - LifeCicle
    init(locationName: String) {
//        self.locationName = locationName
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        layout()
        //        taps()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Metods
    @objc private func hourForecastDetailButtonTap() {
        print("detail day button")
        hourDetailAction?()
    }

    func setupCollectionViews(hourDataSource: UICollectionViewDataSource,
                              hourDelegate: UICollectionViewDelegate,
                              dayDataSource: UICollectionViewDataSource,
                              dayDataDelegate: UICollectionViewDelegate
    ) {
        hourForecastCollectionView.delegate = hourDelegate
        hourForecastCollectionView.dataSource = hourDataSource
        dayForecastCollectionView.dataSource = dayDataSource
        dayForecastCollectionView.delegate = dayDataDelegate
    }

    private func layout() {

        [factView,
        hourForecastDetailButton,
        hourForecastCollectionView,
        dayForecastLabel,
        dayForecastCollectionView].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            factView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            factView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            factView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            factView.heightAnchor.constraint(equalToConstant: 212),

            hourForecastDetailButton.topAnchor.constraint(equalTo: factView.bottomAnchor, constant: 33),
            hourForecastDetailButton.heightAnchor.constraint(equalToConstant: 20),
            hourForecastDetailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            hourForecastCollectionView.topAnchor.constraint(equalTo: hourForecastDetailButton.bottomAnchor, constant: 24),
            hourForecastCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hourForecastCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hourForecastCollectionView.heightAnchor.constraint(equalToConstant: 84),

            dayForecastLabel.topAnchor.constraint(equalTo: hourForecastCollectionView.bottomAnchor, constant: 24),
            dayForecastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dayForecastLabel.heightAnchor.constraint(equalToConstant: 22),

            dayForecastCollectionView.topAnchor.constraint(equalTo: dayForecastLabel.bottomAnchor, constant: 10),
            dayForecastCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayForecastCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayForecastCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
