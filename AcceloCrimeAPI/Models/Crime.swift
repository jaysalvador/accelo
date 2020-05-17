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

    // decoder override to handle dates and numbers
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.month = container.dateIfPresent(forKey: .month)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.location = try container.decodeIfPresent(Location.self, forKey: .location)
        self.outcomeStatus = try container.decodeIfPresent(Outcome.self, forKey: .outcomeStatus)
    }
    
}
