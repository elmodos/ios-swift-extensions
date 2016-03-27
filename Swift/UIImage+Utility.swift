//
//  UIImage+Utility.swift
//  Created by Modo Ltunzher on 11.01.16.
//

import UIKit

extension UIImage // Utility
{
    class func makeColorPixelImage(color: UIColor) -> UIImage!
    {
        return Utility.makeColorImage(color, size: CGSizeMake(1, 1))
    }

    class func makeColorImage(color: UIColor, size: CGSize) -> UIImage!
    {
        var rect = CGRectZero
        rect.size = size
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}