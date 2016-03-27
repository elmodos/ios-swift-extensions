//
//  CGGeometry+Utility.swift
//  Created by Modo Ltunzher on 11.01.16.
//

extension CGRect // Utility
{
    static func scaleToAspectFitRectInRect(rfit: CGRect, rtarget: CGRect) -> CGFloat
    {
        // first try to match width
        let s = CGRectGetWidth(rtarget) / CGRectGetWidth(rfit)
        
        // if we scale the height to make the widths equal, does it still fit?
        if (CGRectGetHeight(rfit) * s <= CGRectGetHeight(rtarget))
        {
            return s
        }
        
        // no, match height instead
        return CGRectGetHeight(rtarget) / CGRectGetHeight(rfit)
    }

    static func aspectFitRectInRect(rfit: CGRect, rtarget: CGRect) -> CGRect
    {
        let s = scaleToAspectFitRectInRect(rfit, rtarget: rtarget)
        let w = CGRectGetWidth(rfit) * s
        let h = CGRectGetHeight(rfit) * s
        let x = CGRectGetMidX(rtarget) - w / 2
        let y = CGRectGetMidY(rtarget) - h / 2
        return CGRectMake(x, y, w, h)
    }

    static func scaleToAspectFitRectAroundRect(rfit: CGRect, rtarget: CGRect) -> CGFloat
    {
        // fit in the target inside the rectangle instead, and take the reciprocal
        return CGFloat(1) / scaleToAspectFitRectInRect(rtarget, rtarget: rfit)
    }

    static func aspectFitRectAroundRect(rfit: CGRect, rtarget: CGRect) -> CGRect
    {
        let s = scaleToAspectFitRectAroundRect(rfit, rtarget: rtarget)
        let w = CGRectGetWidth(rfit) * s
        let h = CGRectGetHeight(rfit) * s
        let x = CGRectGetMidX(rtarget) - w / 2
        let y = CGRectGetMidY(rtarget) - h / 2
        return CGRectMake(x, y, w, h)
    }

    class func centerRect(rect: CGRect, inRect: CGRect) -> CGRect
    {
        let x: CGFloat = (inRect.width - rect.width) * 0.5
        let y: CGFloat = (inRect.height - rect.height) * 0.5
        
        var frame = rect
        frame.origin.x = x
        frame.origin.y = y
        
        return frame
    }

}