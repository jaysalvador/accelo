//
//  Crime.swift
//  Accelo
//
//  Created by Jay Salvador on 17/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public struct Crime: Codable {
    
    public var id: Int?
    public var month: Date?
    public var category: String?
    public var location: Location?
    public var outcomeStatus: Outcome?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case month
        case category
        case location
        case outcomeStatus = "outcome_status"
    }
    
}
