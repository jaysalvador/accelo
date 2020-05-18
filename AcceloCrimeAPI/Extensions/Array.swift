//
//  Array.swift
//  AcceloCrimeAPI
//
//  Created by Jay Salvador on 18/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    public func contains(_ element: Element?) -> Bool {
        
        guard let element = element else {
            
            return false
        }
        
        return self.contains(element)
    }

}
