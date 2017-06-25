//
//  MovieListTableViewCell.swift
//  CinemaDB
//
//  Created by Deepak on 6/25/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.contentMode = .center
            movieImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var backdropView: UIView! 
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePopularity: UILabel!
}
