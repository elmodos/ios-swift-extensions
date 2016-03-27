//
//  Utility.swift
//  Created by Modo Ltunzher on 26.06.14.
//

import UIKit

class Utility
{

// MARK: - Static

    class func applicationDocumentsDirectory() -> String!
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let basePath: String! = paths.count > 0 ? (paths[0] ) : ""
        return basePath
    }

}

