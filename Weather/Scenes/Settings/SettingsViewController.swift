//
//  SettingsViewController.swift
//  Weather
//
//  Created by Filosuf on 14.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    private var storageService: StorageProtocol
    private let coordinator: MainCoordinator

    private let settingLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .Settings.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .Settings.gray
        return label
    }()

    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "Скорость ветра"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .Settings.gray
        return label
    }()

    private let timeFormatLabel: UILabel = {
        let label = UILabel()
        label.text = "Формат времени"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .Settings.gray
        return label
    }()

    private let notificationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомления"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .Settings.gray
        return label
    }()

    private let temperatureSwitch: SettingCustomSwitch = {
        let settingSwitch = SettingCustomSwitch()
        settingSwitch.leftLabel.text = "C"
        settingSwitch.rightLabel.text = "F"
        settingSwitch.setupUI()
        return settingSwitch
    }()

    private let windSpeedSwitch: SettingCustomSwitch = {
        let settingSwitch = SettingCustomSwitch()
        settingSwitch.leftLabel.text = "Mi"
        settingSwitch.rightLabel.text = "Km"
        settingSwitch.setupUI()
        return settingSwitch
    }()

    private let timeFormatSwitch: SettingCustomSwitch = {
        let settingSwitch = SettingCustomSwitch()
        settingSwitch.leftLabel.text = "12"
        settingSwitch.rightLabel.text = "24"
        settingSwitch.setupUI()
        return settingSwitch
    }()

    private let notificationsSwitch: SettingCustomSwitch = {
        let settingSwitch = SettingCustomSwitch()
        settingSwitch.leftLabel.text = "Off"
        settingSwitch.rightLabel.text = "On"
        settingSwitch.setupUI()
        return settingSwitch
    }()

    private let setButton: UIButton = {
        let button = UIButton()
        button.setTitle("Установить", for: .normal)
        button.setTitleColor(.Settings.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .Settings.orange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()

    private let actionBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .Settings.white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private let windSpeedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private let timeFormatStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private let notificationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private let settingsVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    lazy var testTwoView: TestTwoView = {
        let view = TestTwoView()
        return view
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
        view.backgroundColor = .Custom.blue
        navigationItem.hidesBackButton = true
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

    // MARK: - Metods
    @objc private func tap() {
        var settings = Settings()
        settings.temperatureIsF = temperatureSwitch.isOn
        settings.windSpeedIsKm = windSpeedSwitch.isOn
        settings.timeFormatIs24 = timeFormatSwitch.isOn
        settings.notificationsIsOn = notificationsSwitch.isOn
        storageService.settings = settings
        
        coordinator.pop()
    }

    private func setupView() {
        let settings = storageService.settings

        temperatureSwitch.isOn = settings.temperatureIsF
        windSpeedSwitch.isOn = settings.windSpeedIsKm
        timeFormatSwitch.isOn = settings.timeFormatIs24
        notificationsSwitch.isOn = settings.notificationsIsOn
    }

    private func layout() {

        [temperatureLabel,
         temperatureSwitch
        ].forEach { temperatureStackView.addArrangedSubview($0)}

        [windSpeedLabel,
         windSpeedSwitch
        ].forEach { windSpeedStackView.addArrangedSubview($0)}

        [timeFormatLabel,
         timeFormatSwitch
        ].forEach { timeFormatStackView.addArrangedSubview($0)}

        [notificationsLabel,
         notificationsSwitch
        ].forEach { notificationStackView.addArrangedSubview($0)}

        [temperatureStackView,
         windSpeedStackView,
         timeFormatStackView,
         notificationStackView
        ].forEach { settingsVerticalStackView.addArrangedSubview($0)}

        [settingLabel,
         settingsVerticalStackView,
         setButton
        ].forEach { actionBackground.addSubview($0)}

        view.addSubview(actionBackground)

        NSLayoutConstraint.activate([
            actionBackground.heightAnchor.constraint(equalToConstant: 330),
            actionBackground.widthAnchor.constraint(equalToConstant: 320),
            actionBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            settingLabel.topAnchor.constraint(equalTo: actionBackground.topAnchor, constant: 27),
            settingLabel.leadingAnchor.constraint(equalTo: actionBackground.leadingAnchor, constant: 20),

            settingsVerticalStackView.topAnchor.constraint(equalTo: actionBackground.topAnchor, constant: 57),
            settingsVerticalStackView.leadingAnchor.constraint(equalTo: actionBackground.leadingAnchor, constant: 20),
            settingsVerticalStackView.trailingAnchor.constraint(equalTo: actionBackground.trailingAnchor, constant: -30),

            setButton.leadingAnchor.constraint(equalTo: actionBackground.leadingAnchor, constant: 35),
            setButton.trailingAnchor.constraint(equalTo: actionBackground.trailingAnchor, constant: -35),
            setButton.bottomAnchor.constraint(equalTo: actionBackground.bottomAnchor, constant: -16),
            setButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
