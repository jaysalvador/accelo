//
//  CLLocationCoordinate2D.swift
//  Accelo
//
//  Created by Jay Salvador on 18/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}
