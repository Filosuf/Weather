//
//  HourlyForecastViewController.swift
//  Weather
//
//  Created by Filosuf on 12.01.2023.
//

import Foundation
import UIKit

final class HourlyForecastViewController: UIViewController {
    // MARK: - Properties
    private let forecasts: [Indicators]
    private var timeZone: TimeZoneInfo?
    private let dateFormatter = DateTimeFormatter.shared
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HourlyForecastTableViewCell.self, forCellReuseIdentifier: HourlyForecastTableViewCell.identifier)
        return tableView
    }()

    // MARK: - LifeCycle
    init(forecasts: [Indicators], timeZone: TimeZoneInfo?) {
        self.forecasts = forecasts
        self.timeZone = timeZone
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Прогноз на 24 часа"
        layout()
    }

    // MARK: - Methods
    private func convertToViewModel(forecast: Indicators) -> HourForecastViewModel {
        let date = Date(timeIntervalSince1970: forecast.hourTs)
        let dateString = dateFormatter.dateToString(date: date, format: .fullDate, timeZone: timeZone)
        let timeString = dateFormatter.dateToString(date: date, format: .time, timeZone: timeZone)
        let temp = "\(Int(forecast.temp.rounded()))º"
        let feelTemp = "\(Int(forecast.feelsLike.rounded()))º"
        let condition = Conditions.fetchCondition(with: forecast.condition)
        let conditionTitle = Conditions.fetchTitle(with: condition)
        let conditionImageName = Conditions.fetchIconName(with: condition)
        let conditionImage = UIImage(named: conditionImageName)
        let direction = Directions.fetchDirection(with: forecast.windDir)
        let windDirection = Directions.fetchTitle(with: direction)
        let wind = "\(forecast.windSpeed) m/s " + windDirection
        let probabilityOfPrecipitation = "\(forecast.precProb)%"
        return HourForecastViewModel(date: dateString,
                                     time: timeString,
                                     temp: temp,
                                     feelTemp: feelTemp,
                                     conditionTitle: conditionTitle,
                                     conditionImage: conditionImage,
                                     wind: wind,
                                     probabilityOfPrecipitation: probabilityOfPrecipitation)
    }

    private func layout() {

        [tableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDataSource
extension HourlyForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HourlyForecastTableViewCell.identifier, for: indexPath) as! HourlyForecastTableViewCell
        let viewModel = convertToViewModel(forecast: forecasts[indexPath.row])
        cell.setupCell(forecast: viewModel)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension HourlyForecastViewController: UITableViewDelegate {

}
