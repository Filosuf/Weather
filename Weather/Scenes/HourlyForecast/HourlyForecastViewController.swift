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
//    let coordinator: MainCoordinator
    
    let indicatorView = HourlyForecastIndicatorView()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HourlyForecastTableViewCell.self, forCellReuseIdentifier: HourlyForecastTableViewCell.identifier)
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        layout()
        indicatorView.setIndicator(image: UIImage(systemName: "heart.fill")!, name: "Temp", value: "+22")
    }

    // MARK: - Methods
    private func layout() {

        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        [tableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

//            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            indicatorView.heightAnchor.constraint(equalToConstant: 100),
//            indicatorView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
// MARK: - UITableViewDataSource
extension HourlyForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HourlyForecastTableViewCell.identifier, for: indexPath) as! HourlyForecastTableViewCell
        cell.setupCell()
        return cell
    }
}
// MARK: - UITableViewDelegate
extension HourlyForecastViewController: UITableViewDelegate {

}
