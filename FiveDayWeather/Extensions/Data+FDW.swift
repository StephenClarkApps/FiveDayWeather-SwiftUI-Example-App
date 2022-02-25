//
//  Data+FDW.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 24/02/2022.
//

import Foundation

public extension Data {
    
    static func readLocalJsonFileInMainBundle(fileName: String, extenstion: String) -> Data? {
        
        if let filepath = Bundle.main.path(forResource: fileName, ofType: extenstion) {
            do {
                let jsonData = try String(contentsOfFile: filepath).data(using: .utf8)
                return jsonData
            } catch {
                return nil
            }
        }
        
        return nil
    }
}
