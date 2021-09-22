//
//  Colors.swift
//  hhTest
//
//  Created by Андрей Яковлев on 22.09.2021.
//

import UIKit

extension UIColor {
    
    static var mainBg = makeColor(r: 38, g: 38, b: 38, alpha: 1.0)
    static var secBg = makeColor(r: 51, g: 51, b: 51, alpha: 51)
    
    class func makeColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
}
