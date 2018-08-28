//
//  Movie.swift
//  Atelier1_Parsing
//
//  Created by CedricSoubrie on 12/10/2017.
//  Copyright © 2017 CedricSoubrie. All rights reserved.
//

import UIKit

class Movie: NSObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    var title: String = ""
    var overview: String = ""
    var voteAverage: Double = 0.0
    var releaseDate : Date = Date() // The movie DB format : "2017-09-05"
    
    override var description: String {
        return "\(title) - (\(voteAverage)/10) - \(releaseDate) - \(overview)"
    }
    
    static func movieList () -> [Movie] {
        if let jsonData = FileManager.jsonData(fromJSONFile: "BestMovie") {
            let decoder = JSONDecoder()
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            dateFormater.timeZone = TimeZone(identifier: "GMT")
            decoder.dateDecodingStrategy = .formatted(dateFormater)
            do {
                return try decoder.decode ([Movie].self, from: jsonData)
            } catch let error {
                print(error)
            }
        }
        return []
    }
}
