//
//  Colors.swift
//  hhTest
//
//  Created by Андрей Яковлев on 22.09.2021.
//

import UIKit

extension UIColor {
    
    static var mainBg = makeColor(r: 38, g: 38, b: 38)
    static var secBg = makeColor(r: 51, g: 51, b: 51)
    
    static var textMain = makeColor(r: 216, g: 216, b: 216)
    
    class func makeColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
}
