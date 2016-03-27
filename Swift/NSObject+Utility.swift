//
//  NSObject+Utility.swift
//  Created by Modo Ltunzher on 17.10.15.
//

import UIKit

extension NSObject // Utility
{
    static func className() -> String
    {
        //
        var result: String = ""
        
        //
        let className = class_getName(self)
        if let stringFromClass = NSString(CString: className, encoding: NSASCIIStringEncoding)
        {
            // "TargetName.ClassName"
            if let name = stringFromClass.componentsSeparatedByString(".").last
            {
                result = name
            }
        }
        
        //
        return result
    }
}
