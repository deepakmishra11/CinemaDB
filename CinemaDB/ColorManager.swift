//
//  ColorManager.swift
//  CinemaDB
//
//  Created by Deepak on 6/24/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

enum Color: String {
    case AppColor = "E85764"
}

extension UIColor {
    convenience init(color: Color, alpha: CGFloat = 1.0) {
        self.init(hex: color.rawValue, alpha: alpha)
    }
}

private extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
}
