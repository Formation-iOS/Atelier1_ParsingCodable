//
//  Movie.swift
//  Atelier1_Parsing
//
//  Created by CedricSoubrie on 12/10/2017.
//  Copyright © 2017 CedricSoubrie. All rights reserved.
//

import UIKit

typealias JSON = [String:Any]

class Movie: NSObject {
    var title: String = ""
    var overview: String = ""
    var vote_average: Float = 0.0
    var release_date : Date = Date() // The movie DB format : "2017-09-05"
    
    init (json : JSON) {
        self.title = json["title"] as! String
        self.overview = json["overview"] as! String
        self.vote_average = json["vote_average"] as! Float
        
        // Get the date
        let dateString = json["release_date"] as! String
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-mm-dd"
        self.release_date = dateFormater.date(from: dateString)!
    }
    
    override var description: String {
        return "\(title) - (\(vote_average)/10)"
    }
    
    static func movieList (fromFile path: String) -> [Movie] {
        var movies = [Movie] ()
        
        // Transform the file into an array
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            // Build a movie for each of the dictionnary
            if let array = json as? [JSON] {
                for jsonPart in array {
                    let movie = Movie(json: jsonPart)
                    movies.append(movie)
                }
            }
        }
        catch {
            print("Could not get json from file, make sure that file contains valid json.")
        }
        
        return movies
    }
    
    static func movieList () -> [Movie] {
        guard let fileName = Bundle.main.path(forResource: "BestMovie", ofType: "json") else {
            print ("No local json files file with movies inside")
            return []
        }
        return self.movieList(fromFile: fileName)
    }
}
