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
    public var date: Date?
    
    enum CodingKeys: String, CodingKey {
        
        case category
        case date
    }

    // decoder override to handle dates and numbers
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.date = container.dateIfPresent(forKey: .date)
    }
}
