//
//  OverviewSlideView.swift
//  Weather
//
//  Created by Filosuf on 18.01.2023.
//

import UIKit

final class OverviewSlideView: UIView {

    //MARK: - Properties
 private let nameLabel: UILabel = {

        let label = UILabel()
        label.text = "User name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    //MARK: - LifeCicle
    init(name: String) {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        layout()
//        taps()
        setupView(locationName: name)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Metods
//    func taps() {
//        showStatusButton.tapAction =  { [weak self] in
//            self?.statusLabel.text = self?.statusText
//            self?.endEditing(true)
//        }
//        logoutButton.tapAction =  { [weak self] in
//            guard let self = self else {return}
//            self.delegate?.didTapLogoutButton()
//        }
//
//    }

    func setupView(locationName: String) {
        nameLabel.text = locationName
    }

    private func layout() {

        [nameLabel].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 330),
            nameLabel.widthAnchor.constraint(equalToConstant: 320),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

}
