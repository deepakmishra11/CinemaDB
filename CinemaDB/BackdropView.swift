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
        self.mapMovieDetails(movieDetail: movieDetail)
        
        self.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
            self.isHidden = false
            let initialFrame = self.frame
            self.frame = CGRect(x: initialFrame.origin.x, y: initialFrame.origin.y - initialFrame.size.height, width: initialFrame.size.width, height: initialFrame.size.height)
        }) { isCompleted in  }
    }
    
    private func mapMovieDetails(movieDetail: MovieDetail) {
        self.movieSynopsis.text = movieDetail.synopsis
        self.movieLanguages.text = movieDetail.languagesString()
        self.movieGenres.text = movieDetail.genresString()
        self.movieDuration.text = movieDetail.duration
        self.moviePopularity.text = movieDetail.moviePopularity
    }
}
