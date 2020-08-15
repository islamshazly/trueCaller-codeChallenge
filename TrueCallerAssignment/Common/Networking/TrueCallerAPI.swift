//
//  API.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 16/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import Foundation

// MARK: - Protocols
protocol Request {
    var baseURL: URL? { get }
    var path: String { get }
}

extension Request {
    var fullURL: URL? {
        guard baseURL != nil else { return nil }
        
        return URL(string: self.baseURL!.absoluteString + self.path) 
    }
}

enum TrueCallerAPI {
    case tenthChar
    case everyTenthChar
    case wordCount
}

extension TrueCallerAPI: Request {
    
    var baseURL: URL? {
        guard let url = URL(string: Constants.baseURL) else {
            return nil
        }
        
        return url
    }
    
    var path: String {
        return Constants.path
    }
}
