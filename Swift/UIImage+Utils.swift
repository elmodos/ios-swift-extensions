//
//  UIImage+Utils.swift
//  Created by Modo Ltunzher on 2017 Dec 9.
//

import UIKit
import ImageIO

extension UIImage // Resize
{
    
// MARK: - Public

    static func resized(fromFile url: URL, toFitWidth width: CGFloat) -> UIImage?
    {
        var result: UIImage? = nil
        if let (w, h, source) = self.tryGeometry(fromFile: url) {
            let newW = Float(width)
            let newH = Float(width)/Float(w) * Float(h)
            result = self.resized(fromImageSource: source, toFitMax: max(newW, newH))
        }
        return result
    }

    static func resized(fromFile url: URL, toFitHeight height: CGFloat) -> UIImage?
    {
        var result: UIImage? = nil
        if let (w, h, source) = self.tryGeometry(fromFile: url) {
            let newW = Float(height)/Float(h) * Float(w)
            let newH = Float(height)
            result = self.resized(fromImageSource: source, toFitMax: max(newW, newH))
        }
        return result
    }

    static func resized(fromImageSource source: CGImageSource, toFitMax maxSide: Float) -> UIImage?
    {
        var result: UIImage? = nil
        let options: [CFString : Any] = [
            kCGImageSourceThumbnailMaxPixelSize: maxSide,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]
            
        if let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary) {
            result = UIImage(cgImage: cgImage)
        }
        return result
    }
    
    static func tryGeometry(fromFile url: URL) -> (width: Int, height: Int, imageSource: CGImageSource)?
    {
        if let cfUrl = CFURLCreateWithFileSystemPathRelativeToBase(nil, url.path as CFString, .cfurlposixPathStyle, false, nil),
            let imageSource = CGImageSourceCreateWithURL(cfUrl, nil),
            let props = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? Dictionary<String, Any>!,
            let height = props["PixelHeight"] as? Int,
            let width = props["PixelWidth"] as? Int
        {
            return (width, height, imageSource)
        }
        return nil
    }
    
    func resized(toFitWidth width: CGFloat) -> UIImage
    {
        let size = CGSize(width: width, height: width/self.size.width * self.size.height)
        return self.resized(toSize: size)
    }
    
    func resized(toFitHeight height: CGFloat) -> UIImage
    {
        let size = CGSize(width: height/self.size.height * self.size.width, height: height)
        return self.resized(toSize: size)
    }

    func resized(toSize targetSize: CGSize) -> UIImage
    {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
