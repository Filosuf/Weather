//
//  TimeOfDayForecastViewController.swift
//  Weather
//
//  Created by Filosuf on 12.01.2023.
//

import Foundation
import UIKit

final class TimeOfDayForecastsViewController: UIViewController {
// MARK: - Properties
    var selectedCellIndexPath: IndexPath?

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

    private let indicatorView: TimeOfDayForecastView = {
        let view = TimeOfDayForecastView()
        view.setupView()
        return view
    }()

// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        layout()
    }
// MARK: - Methods
    private func layout() {

        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        [indicatorView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
//            dateCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            dateCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            dateCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            dateCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 200),
            indicatorView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }
}
// MARK: - UICollectionViewDataSource
extension TimeOfDayForecastsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as! DateCollectionViewCell
        cell.setupCell(date: "Data")
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
        //selected cell
    }
}
