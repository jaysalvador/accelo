//
//  CrimeClient.swift
//  AcceloCrimeAPI
//
//  Created by Jay Salvador on 18/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public protocol CrimeClientProtocol {
        
    func getCrimes(lat: Double?, lng: Double?, onCompletion: HttpCompletionClosure<[Crime]>?)
        
    func getCrimes(lat: Double?, lng: Double?, date: String?, onCompletion: HttpCompletionClosure<[Crime]>?)
    
    func getCrimes(poly: String?, date: String?, onCompletion: HttpCompletionClosure<[Crime]>?)
        
    func getCrimes(request: CrimeClient.CrimeRequest, onCompletion: HttpCompletionClosure<[Crime]>?)
}

public class CrimeClient: HttpClient, CrimeClientProtocol {
    
    public func getCrimes(lat: Double?, lng: Double?, onCompletion: HttpCompletionClosure<[Crime]>?) {
        
        self.getCrimes(lat: lat, lng: lng, date: "2019-05", onCompletion: onCompletion)
    }
        
    public func getCrimes(lat: Double?, lng: Double?, date: String?, onCompletion: HttpCompletionClosure<[Crime]>?) {
        
        let request = CrimeClient.CrimeRequest(lat: lat, lng: lng, date: date)
        
        self.getCrimes(request: request, onCompletion: onCompletion)
    }
    
    public func getCrimes(poly: String?, date: String?, onCompletion: HttpCompletionClosure<[Crime]>?) {
            
        let request = CrimeClient.CrimeRequest(poly: poly, date: date)
        
        self.getCrimes(request: request, onCompletion: onCompletion)
    }
        
    public func getCrimes(request: CrimeClient.CrimeRequest, onCompletion: HttpCompletionClosure<[Crime]>?) {
        
        let endpoint = "/crimes-street/all-crime\(request.parameters)"
        
        self.request(
            [Crime].self,
            endpoint: endpoint,
            httpMethod: .get,
            headers: nil,
            onCompletion: onCompletion
        )
    }
}
