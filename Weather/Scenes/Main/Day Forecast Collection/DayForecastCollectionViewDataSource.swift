//
//  DayForecastCollectionViewDataSource.swift
//  Weather
//
//  Created by Filosuf on 17.02.2023.
//

import UIKit

class DayForecastCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//    let data: [String]
//
//
//    init(data: [String]) {
//        self.data = data
//    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayForecastCollectionViewCell.identifier, for: indexPath) as! DayForecastCollectionViewCell
        cell.setupCell(date: "01/05")
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
        //selected cell
    }
}
