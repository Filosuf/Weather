//
//  DayForecastCollectionViewDataSource.swift
//  Weather
//
//  Created by Filosuf on 17.02.2023.
//

import UIKit

class DayForecastCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    let data: [String]


    init(data: [String]) {
        self.data = data
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    // Implement the required data source and delegate methods for your first collection view here
}
