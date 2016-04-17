//
//  UIViewController+Helpers.swift
//  Created by Modo Ltunzher on 14.04.16.
//

// TODO: code id "translated" from obj-c, fix

import UIKit

extension UIViewController // Helpers
{
    
// MARK: - Public
    
    class func topViewController() -> UIViewController
    {
        return UIViewController.topViewController(UIApplication.sharedApplication().keyWindow!.rootViewController!)
    }
    
    class func topViewController(rootViewController: UIViewController) -> UIViewController
    {
        if rootViewController.presentedViewController == nil
        {
            return rootViewController
        }
        
        if rootViewController.presentedViewController! is UINavigationController
        {
            let navigationController = rootViewController.presentedViewController as! UINavigationController
            let lastViewController = navigationController.viewControllers.last!
            return self.topViewController(lastViewController)
        }
        
        let presentedViewController = rootViewController.presentedViewController!
        return self.topViewController(presentedViewController)
    }
    
    class func navigationController() -> UINavigationController!
    {
        let topViewController = self.topViewController()
        var navigationController: UINavigationController! = nil
        
        if topViewController is UINavigationController
        {
            navigationController = topViewController as! UINavigationController
        }
        else
        {
            navigationController = topViewController.navigationController
        }
    
        return navigationController
    }

}
