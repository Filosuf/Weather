//
//  TimeOfDayForecastViewController.swift
//  Weather
//
//  Created by Filosuf on 12.01.2023.
//

import Foundation
import UIKit
import CoreData

final class TimeOfDayForecastsViewController: UIViewController {
// MARK: - Properties
    var selectedCellIndexPath: IndexPath?

    private let dateFormatter = DateTimeFormatter.shared
    private var selectedForecastIndex: Int
    private let forecasts: [Forecast]
    private var currentForecast: Forecast { forecasts[selectedForecastIndex] }
    private let timeZone: TimeZoneInfo?

    private let locationNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Text.text
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private let dayForecast: TimeOfDayForecastView = {
        let view = TimeOfDayForecastView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nightForecast: TimeOfDayForecastView = {
        let view = TimeOfDayForecastView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let sunAndMoonView: SunAndMoonView = {
        let view = SunAndMoonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .cyan
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

// MARK: - LifeCycle
    init(index forecastSelected: Int, in forecasts: [Forecast], timeZone: TimeZoneInfo?) {
        selectedForecastIndex = forecastSelected
        self.forecasts = forecasts
        self.timeZone = timeZone
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupView()
        layout()
        let indexPath = IndexPath(row: selectedForecastIndex, section: 0)
        dateCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }

    // MARK: - Methods
    private func setupView() {
        locationNameLabel.text = currentForecast.locationName
        if let dayShort = currentForecast.dayShort {
            dayForecast.setupView(title: "Day", forecast: dayShort)
        }
        if let nightShort = currentForecast.nightShort {
            nightForecast.setupView(title: "Night", forecast: nightShort)
        }
        let sunrise = currentForecast.sunrise ?? "-"
        let sunset = currentForecast.sunset ?? "-"
        let moonPhase = "\(currentForecast.moonCode)"
        sunAndMoonView.setIndicator(daylight: "", sunrise: sunrise, sunset: sunset, moonPhase: moonPhase)
    }

    private func layout() {

        [locationNameLabel,
         dateCollectionView,
         dayForecast,
         nightForecast,
         sunAndMoonView
        ].forEach { contentView.addSubview($0) }

        scrollView.addSubview(contentView)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            locationNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            dateCollectionView.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 40),
            dateCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateCollectionView.heightAnchor.constraint(equalToConstant: 36),

            dayForecast.topAnchor.constraint(equalTo: dateCollectionView.bottomAnchor, constant: 16),
            dayForecast.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayForecast.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dayForecast.heightAnchor.constraint(equalToConstant: 341),

            nightForecast.topAnchor.constraint(equalTo: dayForecast.bottomAnchor, constant: 16),
            nightForecast.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nightForecast.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nightForecast.heightAnchor.constraint(equalToConstant: 341),

            sunAndMoonView.topAnchor.constraint(equalTo: nightForecast.bottomAnchor, constant: 16),
            sunAndMoonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sunAndMoonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            sunAndMoonView.heightAnchor.constraint(equalToConstant: 200),
            sunAndMoonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - UICollectionViewDataSource
extension TimeOfDayForecastsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecasts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as! DateCollectionViewCell
        if let timeZone = timeZone {
            let date = Date(timeIntervalSince1970: forecasts[indexPath.row].date)
            let dateString = dateFormatter.dateToString(date: date, format: .date, timeZone: timeZone)
            cell.setupCell(date: dateString)
        }
//        cell.isSelected = indexPath.row == selectedForecastIndex
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TimeOfDayForecastsViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 36)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedForecastIndex = indexPath.row
        setupView()
    }
}
