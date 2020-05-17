//
//  Outcome.swift
//  Accelo
//
//  Created by Jay Salvador on 17/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public struct Outcome: Codable {
    
    public var category: String?
    public var date: String?
    
    enum CodingKeys: String, CodingKey {
        
        case category
        case date
    }
}
