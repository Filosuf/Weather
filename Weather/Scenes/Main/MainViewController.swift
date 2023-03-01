//
//  MainViewController.swift
//  Weather
//
//  Created by Filosuf on 05.01.2023.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    private let storageService: StorageProtocol
    private let coordinator: MainCoordinator
    private let coreDataManager = CoreDataManager.shared

    private var slides: [OverviewSlideView] = []
    private var locations: [Location] = []
    private var hourCollections = [HourCollectionViewDataSource]()
    private var dayCollections = [DayForecastCollectionViewDataSource]()

    // Для постраничного скрола только в горизонтальном направлении
    private var lastOffsetY: CGFloat = 0
    private var lastOffsetX: CGFloat = 0

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    // MARK: - LifeCycle
    init(storageService: StorageProtocol, coordinator: MainCoordinator) {
        self.storageService = storageService
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        //onboarding
//        if !storageService.firstRunCompleted {
//            coordinator.showOnboarding()
//        }
        //load list locations
        if let locations = storageService.getLocations() {
            self.locations = locations
            slides = createSlides(locations: locations)
            setupSlides()
        }
        loadWeather()
        updateView()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let locations = storageService.getLocations() {
            self.locations = locations
            slides = createSlides(locations: locations)
            setupSlides()
        }
        loadWeather()
    }

    // MARK: - Methods
    private func loadForecast(index: Int) {
        guard index < locations.count else { return }
        let location = locations[index]
        let lat = location.lat
        let lon = location.lon
        let locationName = location.name
        ForecastService().fetchForecast(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let forecast):
                self.coreDataManager.save(forecast, locationName: locationName)
            case .failure(_):
                return
            }
            self.loadForecast(index: index + 1)
        }
    }

    private func loadWeather() {
        let index = 0
        loadForecast(index: index)
    }

    private func updateView() {

    }

    private func getFactDebug() {
        for location in locations {
            let fact = coreDataManager.getFact(locationName: location.name)
            print(fact?.temp as Any)
            let forecasts = coreDataManager.getForecasts(locationName: location.name)
            print("forecasts.count = \(forecasts.count)")
            print(Date())
            for forecast in forecasts {
                print(Date(timeIntervalSince1970: forecast.date))
                print("hours.count = \(forecasts.first?.hoursSorted.count)")
            }
        }
    }

    private func setupSlides() {
        setupSlideScrollView(slides: slides)

        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
    }

    private func setupNavigationBar() {
        title = "NavVC"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "location"), style: .plain, target: self, action: #selector(addLocation))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(showSettings))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }

    @objc private func addLocation() {
        coordinator.showAddLocation()
    }

    @objc private func showSettings() {
        coordinator.showSettings()
    }

    func createSlides(locations: [Location]) -> [OverviewSlideView] {
        var slidesArray = [OverviewSlideView]()
        for location in locations {
            let slide = OverviewSlideView(locationName: location.name)
            let hourForecast = coreDataManager.getHourForecasts(locationName: location.name)
            let timeZone = coreDataManager.getTimeZone(locationName: location.name)
            slide.hourDetailAction = { [weak self] in
                self?.coordinator.showHourlyForecast(forecasts: hourForecast, timeZone: timeZone)
            }

            let hourCollectionViewDataSource = HourCollectionViewDataSource(forecasts: hourForecast, timeZone: timeZone)
            hourCollections.append(hourCollectionViewDataSource)

            let dayForecast = coreDataManager.getForecasts(locationName: location.name)
            let dayCollectionViewDataSource = DayForecastCollectionViewDataSource(forecasts: dayForecast, timeZone: timeZone, coordinator: coordinator)
            dayCollections.append(dayCollectionViewDataSource)
            slide.setupCollectionViews(hourDataSource: hourCollectionViewDataSource, hourDelegate: hourCollectionViewDataSource, dayDataSource: dayCollectionViewDataSource, dayDataDelegate: dayCollectionViewDataSource)
            slidesArray.append(slide)
        }
        return slidesArray
    }

    func setupSlideScrollView(slides : [OverviewSlideView]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 910)
//        scrollView.isPagingEnabled = true

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 910)
            scrollView.addSubview(slides[i])
        }
    }

    private func layout() {

        [scrollView,
        pageControl].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19),
            pageControl.heightAnchor.constraint(equalToConstant: 10),

            scrollView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    //MARK: - Debug

    private func testFetching() {
        let factMoscow = coreDataManager.getFact(locationName: "Moscow")
        print(factMoscow?.temp as Any)
        print(Date().timeIntervalSince1970)
        let forecastMoscow = coreDataManager.getForecasts(locationName: "Moscow")
        print(forecastMoscow.first?.locationName as Any)
        print(forecastMoscow.count as Any)
//        for forecast in forecastMoscow {
//            print(forecast.date as Any)
//            print(forecast.sunrise as Any)
//        }
        let date = Date().timeIntervalSince1970
        for forecast in forecastMoscow {
            print("Date = \(Date(timeIntervalSince1970: forecast.date))")
            for hourForecast in forecast.hoursSorted {
//                print("Count = \(hourForecasts.count)")
                print("date = \(hourForecast.hourTs)")
                if hourForecast.hourTs > date {
                    print(">")
                }
            }
        }
        let hoursForecasts = coreDataManager.getHourForecasts(locationName: "Moscow")
        for hoursForecast in hoursForecasts {
            let date = Date(timeIntervalSince1970: hoursForecast.hourTs)
            print(date as Any)
            print(hoursForecast.temp as Any)
        }
        //        if let hoursForecast = weatherMoscow?.forecastsSorted.first?.hoursSorted {
        //            for hour in hoursForecast {
//                print(hour.hour)
//                print(hour.hourTs)
//                let calendar = Calendar(identifier: .gregorian)
//                let timeZone: TimeZone = .current
//                let dateComponents = calendar.dateComponents(in: timeZone, from: Date(timeIntervalSince1970: hour.hourTs))
//                print("Day = \(dateComponents.day)")
//                print(dateComponents.hour)
//            }
//        }
//        let date = Date()
//        print(date)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        pageControl.currentPageIndicatorTintColor = .blue
        if !locations.isEmpty {
            title = locations[Int(pageIndex)].name
        }
        if scrollView.contentOffset.y != lastOffsetY {
                lastOffsetY = scrollView.contentOffset.y
                scrollView.isPagingEnabled = false
            } else {
                scrollView.isPagingEnabled = true
            }
            if scrollView.contentOffset.x != lastOffsetX {
                lastOffsetX = scrollView.contentOffset.x
                scrollView.isPagingEnabled = true
            } else {
                scrollView.isPagingEnabled = false
            }

    }

    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1

            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor


            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor

            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }


    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {

        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha

        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
