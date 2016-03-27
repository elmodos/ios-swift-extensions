//
//  UIColor+Utility.swift
//  Created by Modo Ltunzher on 12.10.15.
//

import UIKit

extension UIColor // Utility
{

// MARK: - Static
    
    class func fromInts(intRed: Int, intGreen: Int, intBlue: Int, intAlpha: Int = 255) -> UIColor
    {
        return UIColor(red: CGFloat(CGFloat(intRed)/255), green: CGFloat(CGFloat(intGreen)/255), blue: CGFloat(CGFloat(intBlue)/255), alpha: CGFloat(CGFloat(intAlpha)/255))
    }
     
// MARK: - Public

    func blendWithColor(otherColor: UIColor, value: Float) -> UIColor
    {
        let alpha2 = CGFloat(min(1.0, max(0.0, value)))
        let beta = CGFloat(1.0) - alpha2
        
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        otherColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let red = r1 * beta + r2 * alpha2
        let green = g1 * beta + g2 * alpha2
        let blue = b1 * beta + b2 * alpha2
        let alpha = a1 * beta + a2 * alpha2
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
