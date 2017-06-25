//
//  MovieDetailViewController.swift
//  CinemaDB
//
//  Created by Deepak on 6/24/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit
import SafariServices

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.contentMode = .center
            movieImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var backdropView: BackdropView! {
        didSet {
            backdropView.isHidden = true
            
            //initially we will out frame this view, so that later we can present it with animation
            let initialFrame = backdropView.frame
            backdropView.frame = CGRect(x: initialFrame.origin.x, y: initialFrame.origin.y + initialFrame.size.height, width: initialFrame.size.width, height: initialFrame.size.height)
        }
    }
    
    var movieId: Int = 0
    var movieDetail: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(title: "Book", style: .plain, target: self, action: #selector(bookTheMovie))
        self.navigationItem.setRightBarButton(rightBarButton, animated: true)
        
        self.startAnimating(CGSize(width: 30, height: 30), type: .lineScalePulseOutRapid, color: UIColor(color: .AppColor))
        fetchMovieDetails(forMovie: self.movieId)
    }
    
    func fetchMovieDetails(forMovie movieId: Int) {
        let movieDetailRequest = MovieRequest.Detail("\(movieId)").apiEndPoint()
        CinemaApiManager.makeAPICall(endPoint: movieDetailRequest, errorStatus: { error in
            print(error!.rawValue)
        }) { (response: MovieDetail) in
            self.movieDetail = response
            self.setMovieDetails()
        }
    }
    
    func setMovieDetails() {
        self.movieImageView.imageFromServerURL(urlString: self.movieDetail!.moviePosterPath)
        self.backdropView.showMovieDetail(movieDetail: self.movieDetail!)
    }
    
    func bookTheMovie() {
        //http://www.cathaycineplexes.com.sg
        let safariViewController = SFSafariViewController(url: URL(string: "http://www.cathaycineplexes.com.sg")!)
        safariViewController.preferredBarTintColor = UIColor(color: .AppColor)
        self.present(safariViewController, animated: true, completion: nil)
    }
}
