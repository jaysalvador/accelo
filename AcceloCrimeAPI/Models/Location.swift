//
//  Location.swift
//  Accelo
//
//  Created by Jay Salvador on 17/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public struct Location: Codable {
    
    public var longitude: Double?
    public var latitude: Double?
    public var name: String?
    
    enum CodingKeys: String, CodingKey {
        
        case longitude
        case latitude
        case name
        case street
    }

    // decoder override to handle dates and numbers
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.longitude = container.doubleIfPresent(forKey: .longitude)
        self.latitude = container.doubleIfPresent(forKey: .latitude)
        
        if let streetContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .street) {
            
            self.name = try streetContainer.decodeIfPresent(String.self, forKey: .street)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.name, forKey: .name)
    }
}
