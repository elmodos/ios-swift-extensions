//
//  String+NSString.swift
//  Created by Modo Ltunzher on 09.10.15.
//

import Foundation

public extension String
{

// MARK: - Static    

    static func avoidNullString(val: String?) -> String
    {
        var result: String = ""
        
        if let s = val
        {
            result = s
        }
        
        return result
    }
    
// MARK: - Public 

    func toNSString() -> NSString
    {
        return (self as NSString)
    }

    func length() -> Int
    {
        return self.characters.count
    }
    
    func empty() -> Bool
    {
        return length() == 0
    }
    
    func isEmpty() -> Bool
    {
        return length() == 0
    }

    func trimmedString() -> String
    {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }

        func isValidEmailAddress() -> Bool
    {
        //
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        //
        return emailTest.evaluateWithObject(self)
    }

}