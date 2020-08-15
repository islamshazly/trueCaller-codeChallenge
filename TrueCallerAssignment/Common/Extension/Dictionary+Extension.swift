//
//  Dictionary+Extension.swift
//  TrueCallerAssignment
//
//  Created by islam Elshazly on 18/11/2019.
//  Copyright © 2019 IslamElshazly. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func toPrttyString() throws -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            return "\(decoded)"
        } catch {
            return "Cant Make It pretty"
        }
    }
}
