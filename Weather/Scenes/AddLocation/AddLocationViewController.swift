//
//  AddLocationViewController.swift
//  Weather
//
//  Created by Filosuf on 12.01.2023.
//

import UIKit

class AddLocationViewController: UIViewController {

    //MARK: - Properties
    private let geocodingService = GeocodingService()
    private let storageService = SettingsStorageService()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchLocations = [Location]()
    private var coordinator: MainCoordinator

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    //MARK: - LifeCicle
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .white
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        layout()
    }

    //MARK: - Methods
    private func layout() {
        [tableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
//MARK: - UITableViewDataSource
extension AddLocationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let location = searchController.searchBar.text else { return }
        geocodingService.fetchLocations(for: location) { [weak self] result in
            switch result {
            case .success(let locations):
                DispatchQueue.main.async {
                    self?.searchLocations = locations
                    self?.tableView.reloadData()
                }
            case .failure(_):
                return
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension AddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchLocations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let location = searchLocations[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = location.address
        cell.contentConfiguration = content
        return cell
    }
}
//MARK: - UITableViewDelegate
extension AddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectLocation = searchLocations[indexPath.row]
        storageService.addLocation(selectLocation)
        coordinator.pop()
    }
}
