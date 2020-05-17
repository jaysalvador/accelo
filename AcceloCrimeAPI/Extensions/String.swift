//
//  String.swift
//  AcceloCrimeAPI
//
//  Created by Jay Salvador on 18/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns the date value of the String based on the formats determined from the API
    public func toDate() -> Date? {
        
        if let dateMonth = DateFormatter.dateMonth.date(from: self) {
            
            return dateMonth
        }
        
        return nil
    }
}
