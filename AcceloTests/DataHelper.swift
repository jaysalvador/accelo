//
//  DataHelper.swift
//  AcceloTests
//
//  Created by Jay Salvador on 18/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import Accelo
import AcceloCrimeAPI

class DataHelper {

    class func getData(completion: HttpCompletionClosure<[Crime]>?) {

        let dataPath = Bundle(for: DataHelper.self).path(forResource: "data", ofType: "json") ?? ""
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: dataPath))
            
            let decoder = JSONDecoder()

            decoder.dateDecodingStrategy = .formatted(.dateMonth)

            let decoded = try decoder.decode([Crime].self, from: data)
            
            completion?(.success(decoded))
        }
        catch {

            completion?(.failure(HttpError.decoding(error)))
        }
    }
}
