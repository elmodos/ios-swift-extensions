//
//  NSObject+Synchronized.swift
//  Created by Modo Ltunzher on 17.04.16.
//

import Foundation

extension NSObject // Synchronized
{
    
// MARK: - Public
    
    func synchronized(closure: (() -> ()))
    {
        objc_sync_enter(self)
        closure()
        objc_sync_exit(self)
    }
    
}
