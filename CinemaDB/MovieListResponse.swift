//
//  MovieListResponse.swift
//  CinemaDB
//
//  Created by Deepak on 6/24/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieList: Mappable {
    var movies: [Movie] = []
    
    init?(map: Map){
    }
    
    mutating func mapping(map: Map) {
        movies <- map["results"]
    }
}

struct Movie: Mappable {
    var movieId: Int = 0
    var movieTitle = ""
    var moviePopularity: Double = 0
    var moviePosterPath = ""
    
     init?(map: Map){
        if let movieId = map.JSON["id"] as? Int {
            self.movieId = movieId
        }
        if let movieTitle = map.JSON["title"] as? String {
            self.movieTitle = movieTitle
        }
        if let moviePopularity = map.JSON["popularity"] as? Double {
            self.moviePopularity = moviePopularity
        }
        if let moviePosterPath = map.JSON["poster_path"] as? String {
            self.moviePosterPath = moviePosterPath
        }
    }
    
    mutating func mapping(map: Map) {
        movieId <- map["id"]
        movieTitle <- map["title"]
        moviePopularity <- map["popularity"]
        moviePosterPath <- map["poster_path"]
    }
}
