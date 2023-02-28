//
//  HourCollectionViewDataSource.swift
//  Weather
//
//  Created by Filosuf on 17.02.2023.
//

import UIKit

final class HourCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var forecasts = [Indicators]()
    private var timeZone: TimeZoneInfo?
    private let dateFormatter = DateTimeFormatter.shared

    init(forecasts: [Indicators], timeZone: TimeZoneInfo?) {
        self.forecasts = forecasts
        self.timeZone = timeZone
    }

    func updateForecast(forecasts: [Indicators], timeZone: TimeZoneInfo?) {
        self.forecasts = forecasts
        self.timeZone = timeZone
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecasts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier, for: indexPath) as! HourCollectionViewCell

        let forecast = forecasts[indexPath.row]
        let temp = Int(forecast.temp.rounded())
        let date = Date(timeIntervalSince1970: forecast.hourTs)
        let time = dateFormatter.dateToString(date: date, format: .time, timeZone: timeZone)
        let condition = Conditions.fetchCondition(with: forecast.condition ?? "")
        let conditionImageName = Conditions.fetchIconName(with: condition)
        let conditionImage = UIImage(named: conditionImageName)
        cell.setupCell(time: time, temp: temp, conditionImage: conditionImage)
        return cell
    }


    //MARK: - UICollectionViewDelegateFlowLayout
    private var sideInset: CGFloat { return 16}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 42, height: 84)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        sideInset
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selected cell
    }
}
