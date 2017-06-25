//
//  MovieDetailResponse.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieDetail: Mappable {
    var movieId: Int = 0
    var movieTitle = ""
    var moviePopularity = ""
    var moviePosterPath = ""
    var synopsis = ""
    var genres: [Genre] = []
    var languages: [Language] = []
    var duration = ""
    
    init?(map: Map){
        if let movieId = map.JSON["id"] as? Int {
            self.movieId = movieId
        }
        if let movieTitle = map.JSON["title"] as? String {
            self.movieTitle = movieTitle
        }
        if let moviePopularity = map.JSON["popularity"] as? Double {
            self.moviePopularity = "Popularity: \(moviePopularity)"
        }
        if let moviePosterPath = map.JSON["poster_path"] as? String {
            self.moviePosterPath = moviePosterPath
        }
        if let synopsis = map.JSON["overview"] as? String {
            self.synopsis = synopsis
        }
        if let genres = map.JSON["genres"] as? [Genre] {
            self.genres = genres
        }
        if let languages = map.JSON["spoken_languages"] as? [Language] {
            self.languages = languages
        }
        if let duration = map.JSON["runtime"] as? Int {
            self.duration = "Duration: \(duration) mins"
        }
    }
    
    mutating func mapping(map: Map) {
        movieId <- map["id"]
        movieTitle <- map["title"]
        moviePopularity <- map["popularity"]
        moviePosterPath <- map["poster_path"]
        synopsis <- map["overview"]
        genres <- map["genres"]
        languages <- map["spoken_languages"]
        duration <- map["runtime"]
    }
}

extension MovieDetail {
    func languagesString() -> String {
        var text = "Languages: "
        let languages = self.languages.map({ $0.name })
        for name in languages {
            text.append(name)
            text.append(",")
        }
        text = String(text.characters.dropLast())
        return text
    }
    
    func genresString() -> String {
        var text = "Genres: "
        let genres = self.genres.map({ $0.name })
        for name in genres {
            text.append(name)
            text.append(",")
        }
        text = String(text.characters.dropLast())
        return text
    }
}


struct Genre: Mappable {
    var id: Int = 0
    var name = ""
    
    init?(map: Map){
        if let id = map.JSON["id"] as? Int {
            self.id = id
        }
        if let name = map.JSON["name"] as? String {
            self.name = name
        }
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

struct Language: Mappable {
    var name = ""
    
    init?(map: Map){
        if let name = map.JSON["name"] as? String {
            self.name = name
        }
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
    }
}
