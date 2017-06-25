//
//  GradientView.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

class BackdropView: UIView {
    @IBOutlet weak var movieSynopsis: UILabel! {
        didSet {
            movieSynopsis.numberOfLines = 0
            movieSynopsis.sizeToFit()
        }
    }
    @IBOutlet weak var movieLanguages: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var moviePopularity: UILabel!

    func showMovieDetail(movieDetail: MovieDetail) {
        self.movieSynopsis.text = movieDetail.synopsis
        
        self.movieLanguages.text = "Languages: "
        let languages = movieDetail.languages.map({ $0.name })
        for name in languages {
            self.movieLanguages.text!.append(name)
            self.movieLanguages.text!.append(",")
        }
        
        self.movieGenres.text = "Genres: "
        let genres = movieDetail.genres.map({ $0.name })
        for genre in genres {
            self.movieGenres.text!.append(genre)
            self.movieGenres.text!.append(",")
        }
        
        self.movieDuration.text = "Duration: " + movieDetail.duration
        self.moviePopularity.text = "Popularity: " + "\(movieDetail.moviePopularity)"
        
        self.setNeedsUpdateConstraints()
    }
}
