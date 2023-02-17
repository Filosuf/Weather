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
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 18)
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
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = .Main.selectHourCell
                    self.layer.borderColor = UIColor.Main.selectHourCell.cgColor
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
        [timeLabel].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            timeLabel.bottomAnchor.constraint(equalTo: conditionImage.topAnchor, constant: -interval),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            conditionImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            conditionImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            tempLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant: interval),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
