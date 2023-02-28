//
//  DayForecastCollectionViewDataSource.swift
//  Weather
//
//  Created by Filosuf on 17.02.2023.
//

import UIKit

class DayForecastCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var forecasts = [Forecast]()
    private var timeZone: TimeZoneInfo?
    private let dateFormatter = DateTimeFormatter.shared
    private let coordinator: MainCoordinator

    init(forecasts: [Forecast], timeZone: TimeZoneInfo?, coordinator: MainCoordinator) {
        self.forecasts = forecasts
        self.timeZone = timeZone
        self.coordinator = coordinator
    }

    func updateForecast(forecasts: [Forecast], timeZone: TimeZoneInfo?) {
        self.forecasts = forecasts
        self.timeZone = timeZone
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecasts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayForecastCollectionViewCell.identifier, for: indexPath) as! DayForecastCollectionViewCell
        
        let forecast = forecasts[indexPath.row]
        let date = Date(timeIntervalSince1970: forecast.date)
        guard let dayForecast = forecast.dayShort, let nightForecast = forecast.nightShort else { return UICollectionViewCell()}
        let dateShort = dateFormatter.dateToString(date: date, format: .date, timeZone: timeZone)
        let precProb = "\(dayForecast.precProb)"
        let tempMin = "\(Int(nightForecast.temp.rounded()))"
        let tempMax = "\(Int(dayForecast.temp.rounded()))"
        let condition = Conditions.fetchCondition(with: dayForecast.condition ?? "h")
        let iconName = Conditions.fetchIconName(with: condition)
        let iconImage = UIImage(named: iconName)
        let conditionTitle = Conditions.fetchTitle(with: condition)
        cell.setupCell(date: dateShort,
                       conditionImage: iconImage,
                       probabilityOfPrecipitation: precProb,
                       condition: conditionTitle,
                       tempMax: tempMax,
                       tempMin: tempMin)
        return cell
    }


    //MARK: - UICollectionViewDelegateFlowLayout
    private var sideInset: CGFloat { return 16}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 2 * sideInset
        return CGSize(width: width, height: 56)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        sideInset
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.showTimeOfDayForecast(index: indexPath.row, in: forecasts, timeZone: timeZone)
    }
}
