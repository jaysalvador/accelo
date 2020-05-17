//
//  Date.swift
//  AcceloCrimeAPI
//
//  Created by Jay Salvador on 18/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension Date {
    
    /// Uses a `DateFormatter` to return the `String` formatted `Date` value
    /// - Parameter dateFormatter: user-defined `DateFormatter`
    /// - Parameter timezone: custom `TimeZone`
    public func toString(using dateFormatter: DateFormatter?, in timezone: String? = nil) -> String? {

        dateFormatter?.timeZone = TimeZone(identifier: timezone ?? TimeZone.current.identifier)

        return dateFormatter?.string(from: self)
    }
}
