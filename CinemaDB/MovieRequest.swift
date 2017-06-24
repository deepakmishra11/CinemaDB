//
//  Movie.swift
//  CinemaDB
//
//  Created by Deepak on 6/24/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import Foundation

enum MovieRequest {
    case List(String, String, Int)
    case Detail(String)
}

extension MovieRequest: HTTPEndPointDSL {
    func apiEndPoint() -> HTTPEndPoint {
        switch self {
        case .List(let releaseDate, let sortBy, let page):
            return GET(resource: "discover/movie", initializer: {
                $0.params["primary_release_date.lte"] = releaseDate
                $0.params["sort_by"] = sortBy
                $0.params["page"] = page
            })
        case .Detail(let movieId):
            return GET(resource: "movie/\(movieId)")
        }
    }
}
