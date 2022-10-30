//
//  UIColorExtenstion.swift
//  1Pharmacy
//
//  Created by mohamed elmaazy on 6/21/18.
//  Copyright © 2018 mohamed elmaazy. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func fromHex(hex:String, alpha: CGFloat = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    open class var appOrange: UIColor {
        return #colorLiteral(red: 0.9490196078, green: 0.4, blue: 0.1529411765, alpha: 1)
    }
    open class var outerSpace: UIColor {
        return #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
    }
    open class var tealBlue: UIColor {
        return #colorLiteral(red: 0.1960784314, green: 0.3647058824, blue: 0.4745098039, alpha: 1)
    }
}
