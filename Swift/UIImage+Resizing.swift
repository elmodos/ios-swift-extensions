//
//  UIImage+resizing.swift
//  Created by Modo Ltunzher on 20.02.15.
//

import UIKit

extension UIImage // Resizing
{
    
    func scaleToFit(size: CGSize) -> UIImage!
    {
        let selfRatio = self.size.width / self.size.height
        let newRatio = size.width / size.height
        
        var newSize = self.size
        
        if selfRatio < newRatio
        {
            // fit by width
            newSize.height = size.height * size.width / newSize.width
            newSize.width = size.width
        }
        else
        {
            // fit height
            newSize.width = size.width * size.height / newSize.height
            newSize.height = size.height
        }
        
        return self.resize(newSize)
    }
    
    func scaleToFill(size: CGSize) -> UIImage!
    {
        let selfRatio = self.size.width / self.size.height
        let newRatio = size.width / size.height
        
        var newSize = self.size
        
        if selfRatio > newRatio
        {
            // fit by width
            newSize.height = newSize.height * size.width / newSize.width
            newSize.width = size.width
        }
        else
        {
            // fit height
            newSize.width = newSize.width * size.height / newSize.height
            newSize.height = size.height
        }
        
        return self.resize(newSize)
    }
    
    func resize(size: CGSize, scale: CGFloat = 0) -> UIImage!
    {
        var result: UIImage! = self

        //
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        //let context = UIGraphicsGetCurrentContext()
        
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        result = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        //
        return result
    }
    
}

