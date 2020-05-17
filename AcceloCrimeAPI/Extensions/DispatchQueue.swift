//
//  DispatchQueue.swift
//  Accelo
//
//  Created by Jay Salvador on 17/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    /// Accessible variable for the Background Queue
    public class var background: DispatchQueue {
        
        return DispatchQueue.global(qos: .background)
    }
    
    public func debounce(delay: DispatchTimeInterval, action: @escaping (() -> Void)) -> (() -> Void) {
        
        var currentWorkItem: DispatchWorkItem?
        
        return { [weak self] in
            
            currentWorkItem?.cancel()
            currentWorkItem = DispatchWorkItem { action() }
            
            self?.asyncAfter(deadline: .now() + delay, execute: currentWorkItem!)
        }
    }
}
