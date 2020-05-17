//
//  ViewModel.swift
//  Accelo
//
//  Created by Jay Salvador on 18/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import AcceloCrimeAPI

public typealias ViewModelCallback = (() -> Void)

protocol ViewModelProtocol {
    
    // MARK: - Data
    
    var lat: Double { get set }
    
    var lng: Double { get set }
    
    var date: Date? { get set }
    
    var crimes: [Crime]? { get }
    
    var error: HttpError? { get }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func getCrimes()
}

class ViewModel: ViewModelProtocol {
    
    private var crimeClient: CrimeClientProtocol?
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    // MARK: - Data
    
    var lat: Double
    
    var lng: Double
    
    var date: Date?
    
    private(set) var crimes: [Crime]?
    
    private(set) var error: HttpError?
    
    // MARK: - Init
    
    convenience init() {
        
        self.init(client: CrimeClient())
    }
    
    init(client _client: CrimeClientProtocol?) {
        
        self.crimeClient = _client
        
        self.lat = 51.4999578
        
        self.lng = -0.1260483
        
        self.date = "2019-05".toDate()
    }
    
    // MARK: - Functions
    
    func getCrimes() {
        
        self.crimeClient?.getCrimes(
            lat: self.lat,
            lng: self.lng,
            date: self.date?.toString(using: .dateMonth)
        ) { [weak self] response in
            
            switch response {
            case .success(let crimes):
                
                self?.crimes = crimes
                
                self?.onUpdated?()
                
            case .failure(let error):
                
                self?.error = error
                
                self?.onError?()
            }
            
        }
    }
    
}
