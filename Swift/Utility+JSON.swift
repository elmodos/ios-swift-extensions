//
//  Utility+JSON.swift
//  Created by Modo Ltunzher on 26.06.14.
//

import UIKit

extension Utility // JSON
{
    
// MARK: - Static

    class func dictionaryToJSONData(dictionary: NSDictionary, printJSONString: Bool = false) -> NSData
    {
        let data: NSData? = try? NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions(rawValue: 0))

        if (printJSONString && data != nil)
        {
            let jsonString = NSString(bytes: data!.bytes, length: data!.length, encoding: NSUTF8StringEncoding)
            print("JSON data: \n", jsonString)
        }
        
        return data == nil ? NSData() : data!
    }

    class func JSONDataToDictionary(data: NSData!, printJSONString: Bool = false) -> NSDictionary
    {
        if data == nil
        {
            return NSDictionary()
        }
        
        let error: NSError? = nil
        let object: NSDictionary? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
        if (error != nil)
        {
            print("Error while loading keyboard file \(error)")
        }
        
        if (printJSONString && object != nil)
        {
            let jsonString = NSString(bytes: data.bytes, length: data.length, encoding: NSUTF8StringEncoding)
            print("JSON data: \n", jsonString)
        }
        
        return object == nil ? NSDictionary() : object!
    }
    
}

