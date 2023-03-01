//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Filosuf on 23.01.2023.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    static let identifier = "DateCollectionViewCell"

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = .blue
                    self.dateLabel.textColor = .white
                }
            }
            else {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = .white
                    self.dateLabel.textColor = .black
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(date: String) {
        dateLabel.text = date
    }

    private func layout() {
        [dateLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
