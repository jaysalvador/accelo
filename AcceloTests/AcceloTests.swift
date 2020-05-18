//
//  AcceloTests.swift
//  AcceloTests
//
//  Created by Jay Salvador on 17/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import XCTest
@testable import Accelo
@testable import AcceloCrimeAPI

class AcceloTests: XCTestCase {

    func testExample() throws {
        
        let crimes = self.getCrimes()
        
        XCTAssertEqual(crimes.count, 128, "data must have 128 crimes")
        
        let lastCrime = crimes.last
        
        XCTAssertEqual(lastCrime?.title, "Violent Crime", "Crime must be: Violent Crime")
        
        XCTAssertEqual(lastCrime?.outcomeStatus?.category, "Status update unavailable", "Status must be: Status update unavailable")
    }

    func getCrimes() -> [Crime] {
        
        let expectation = self.expectation(description: "no data recieved")
        
        var crimes = [Crime]()
        
        DataHelper.getData { (response) in
            
            switch response {
                
            case .success(let _crimes):
                
                crimes = _crimes
                
            case .failure:
                
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        return crimes
    }

}
