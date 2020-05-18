//
//  CrimeClient.CrimeRequest.swift
//  AcceloCrimeAPI
//
//  Created by Jay Salvador on 18/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension CrimeClient {
    
    public struct CrimeRequest: Encodable {
        
        public var lat: Double?
        public var lng: Double?
        public var date: String?
        public var poly: String?
        
        enum CodingKeys: String, CodingKey {
            
            case lat
            case lng
            case date
            case poly
        }
        
        var parameters: String {
            
            return UrlParameters()
                .with(key: CodingKeys.poly, value: self.poly)
                .with(key: CodingKeys.lat, value: self.lat)
                .with(key: CodingKeys.lng, value: self.lng)
                .with(key: CodingKeys.date, value: self.date)
                .flattened
        }
        
        init(lat: Double?, lng: Double?, date: String?) {
            
            self.lat = lat
            self.lng = lng
            self.date = date
        }
        
        init(poly: String?, date: String?) {
            
            self.poly = poly
            self.date = date
        }
    }
}
