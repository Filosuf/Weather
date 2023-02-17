//
//  HourCollectionViewCell.swift
//  Weather
//
//  Created by Filosuf on 16.02.2023.
//

import UIKit

final class HourCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "HourCollectionViewCell"

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Text.text
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let conditionImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Text.textGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = .Main.blueSecond
                    self.layer.borderColor = UIColor.Main.blueSecond.cgColor
                }
            }
            else {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = .white
                    self.layer.borderColor = UIColor.Main.borderHourCell.cgColor
                }
            }
        }
    }

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingCell()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func setupCell(time: String) {
        timeLabel.text = time
        conditionImage.image = UIImage(named: "moon")
        tempLabel.text = "11º"
    }

    private func settingCell() {
        backgroundColor = .white
        layer.cornerRadius = 22
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.Main.borderHourCell.cgColor
    }

    private func layout() {
        let interval: CGFloat = 5
        [timeLabel,
        conditionImage,
        tempLabel
        ].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            timeLabel.bottomAnchor.constraint(equalTo: conditionImage.topAnchor, constant: -interval),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 18),

            conditionImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            conditionImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            tempLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant: interval),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
