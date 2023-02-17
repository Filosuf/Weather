//
//  FactView.swift
//  Weather
//
//  Created by Filosuf on 25.01.2023.
//

import Foundation
import UIKit

final class FactView: UIView {
    // MARK: - Properties
    
    // MARK: - LifeCycle
    init() {
        super.init(frame: CGRect.zero)
        layout()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    func setupView() {
//        self.image.image = image
//        nameLabel.text = name
//        valueLabel.text = value
    }

    private func layout() {

//        [image, nameLabel, valueLabel].forEach { self.addSubview($0) }
//
//        NSLayoutConstraint.activate([
//            image.centerYAnchor.constraint(equalTo: centerYAnchor),
//            image.leadingAnchor.constraint(equalTo: leadingAnchor),
//            image.heightAnchor.constraint(equalToConstant: 12),
//            image.widthAnchor.constraint(equalToConstant: 12),
//
//            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 4),
//
//            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
    }
}
