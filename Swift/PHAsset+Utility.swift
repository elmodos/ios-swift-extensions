//
//  PHAsset+Utility.swift
//  Created by Modo Ltunzher on 22.12.15.
//

import Photos

extension PHAsset // Utility
{
    class func getAssetFromlocalIdentifier(localIdentifier: String) -> PHAsset?
    {
        var result: PHAsset? = nil
        
        let list = PHAsset.fetchAssetsWithLocalIdentifiers([localIdentifier], options: nil)
        if list.count > 0
        {
            result = list.objectAtIndex(0) as? PHAsset
        }
        
        return result
    }

}
