//
//  UIViewController+Utility.swift
//  Created by Modo Ltunzher on 21.03.16.
//

import UIKit

extension UIViewController // Utility
{

    func dismissAnimated()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissNotAnimated()
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

}
