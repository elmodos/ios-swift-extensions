//
//  NSURL+Utility.swift
//  Created by Modo Ltunzher on 21.03.16.
//

import UIKit

extension NSURL
{
    var queryItems: [String : String]
    {
        //
        var result: [String : String] = [ : ]
        
        //
        if let res = NSURLComponents(URL: self, resolvingAgainstBaseURL: false)?.queryItems?.reduce([:], combine: {
                (var params: [String : String], item) -> [String : String] in
                params[item.name] = item.value
                return params
            })
        {
            result = res
        }
        else
        {
            result = [ : ]
        }
        
        return result
    }
}