//
//  HttpError.swift
//  Accelo
//
//  Created by Jay Salvador on 17/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

/// Error return states for `HttpClient`
public enum HttpError: Error {
    
    case network(Error)
    case noData(URLResponse?)
    case decoding(Error)
    case server(URLResponse?)
    case nilRequest
    case unknown(statusCode: Int?, data: Data?)
}

extension HttpError: LocalizedError {
    
    public var title: String {
         
        switch self {
        case .network:
            
            return "Network Error"
        case .noData:
            
            return "Data Error"
        case .decoding:
            
            return "Decoding Error"
        case .server:
            
            return "Server Error"
        case .nilRequest:
            
            return "Nil Request Error"
        case .unknown:
            
            return "Unknown Error"
        }
    }
    
    /// Returns a string representation of the error
    public var errorDescription: String? {
        
        switch self {
        case .network(let error):
            
            return "Network: " + error.localizedDescription
            
        case .server(let response):
            
            return "Server " + (response.map { "response\($0)" } ?? "no repsonse")
            
        case .noData(let response):
            
            return "No data " + (response.map { "response\($0)" } ?? "no repsonse")
            
        case .decoding(let error):
            
            return "Decoding: " + error.localizedDescription
            
        case .nilRequest:
            
            return "Nil Request"
            
        case .unknown(let statusCode, let data):

            var rawString: String?
            
            if let data = data {
                
                rawString = String(data: data, encoding: .utf8)
            }
            
            return "Unknown Error: Status - \(statusCode ?? 0) | data - \(rawString ?? "")"
        }
    }
}
