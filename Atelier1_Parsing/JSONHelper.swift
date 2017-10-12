//
//  JSONHelper.swift
//  Atelier1_Parsing
//
//  Created by CedricSoubrie on 12/10/2017.
//  Copyright © 2017 CedricSoubrie. All rights reserved.
//

import Foundation

typealias JSON = [String:Any]

extension FileManager {
    
    
    static func jsonData (fromJSONFile fileName:String) -> Data? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print ("No local json files for path \(fileName)")
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: [])
            return data
        }
        catch {
            print ("Error while reading file \(fileName)")
            return nil
        }
    }
}
