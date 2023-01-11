//
//  UIColor+Extension.swift
//  Weather
//
//  Created by Filosuf on 14.12.2022.
//

import UIKit

extension UIColor {
    enum Custom {
        static var blue: UIColor { UIColor(named: "customBlue")! }
        static var naturalWhite: UIColor { UIColor(named: "naturalWhite")! }
    }

    enum Settings {
        static var gray: UIColor { UIColor(named: "settingsNameGray")! }
        static var white: UIColor { UIColor(named: "settingsNameWhite")! }
        static var black: UIColor { UIColor(named: "settingsNameBlack")! }
        static var orange: UIColor { UIColor(named: "settingsOrange")! }
    }
}
