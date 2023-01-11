//
//  SettingCustomSwitch.swift
//  Weather
//
//  Created by Filosuf on 15.12.2022.
//

import UIKit


final class SettingCustomSwitch: CustomSwitch {

    init() {
        super.init(frame: .zero)
        self.cornerRadius = 5/30
        self.onThumbMaskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.offThumbMaskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.thumbTintColor = .Custom.naturalWhite
        self.padding = 0
        self.isOn = true
        self.onTintColor = .Custom.blue
        self.offTintColor = .Custom.blue
        //label
        self.labelOverlapsThumb = true
        self.areLabelsShown = true
        self.onThumbLabelTextColor = .Settings.black
        self.offThumbLabelTextColor = .Settings.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
