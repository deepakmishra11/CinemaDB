//
//  MovieListViewController.swift
//  CinemaDB
//
//  Created by Deepak on 6/24/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    //MARK: - Instance Variables
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor.clear
            tableView.tableHeaderView = UIView()
            tableView.tableFooterView = UIView()
        }
    }
    
    var movieList: [Movie] = []
    var apiPageNumber = 1
    
    private lazy var refreshControl: UIRefreshControl = {
        let refControl = UIRefreshControl()
        refControl.tintColor = UIColor(color: .AppColor)
        refControl.addTarget(self, action: #selector(refreshMovieList), for: .valueChanged)
        self.tableView.refreshControl = refControl
        return refControl
    }()
    
    
    //MARK:- View Controller's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"

        self.startAnimating(CGSize(width: 30, height: 30), type: .lineScalePulseOutRapid, color: UIColor(color: .AppColor))
        self.fetchTheMovieList()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath, segue.identifier == Segue.MovieDetail.rawValue {
            let movie = self.movieList[indexPath.row]
            
            let movieDetailViewController = segue.destination as! MovieDetailViewController
            movieDetailViewController.movieId = movie.movieId
            movieDetailViewController.title = movie.movieTitle
        }
    }
    
    //MARK:- Local Methods
    func refreshMovieList() {
        self.apiPageNumber = 1
        self.movieList.removeAll()
        fetchTheMovieList()
    }
    
    /**
     Use this method to get the movie list from backend
     */
    func fetchTheMovieList() {
        let movieListRequest = MovieRequest.List(Date.today(), "release_date.desc", self.apiPageNumber).apiEndPoint()
        CinemaApiManager.makeAPICall(endPoint: movieListRequest, errorStatus: { error in
            self.stopAnimating()
            self.refreshControl.endRefreshing()
            print(error)
        }) { (response: MovieList) in
            self.stopAnimating()
            self.refreshControl.endRefreshing()
            self.movieList += response.movies
            self.tableView.reloadData()
        }
    }
}




extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? LoadingTableViewCell {
            cell.loadingView.isHidden = false
            cell.loadingView.startAnimating()
            self.apiPageNumber += 1
            self.fetchTheMovieList()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? LoadingTableViewCell {
            cell.loadingView.isHidden = true
            cell.loadingView.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.movieList.count {
            return UITableViewAutomaticDimension
        }
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(segue: .MovieDetail, sender: indexPath)
    }
}



extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if self.movieList.count > 0 {
            count = self.movieList.count + 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.movieList.count {
            let cell = tableView.dequeCellForIndexPath(forIndexPath: indexPath) as LoadingTableViewCell
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        }
        
        let cell = tableView.dequeCellForIndexPath(forIndexPath: indexPath) as MovieListTableViewCell
        let movie = self.movieList[indexPath.row]
        
        cell.movieImageView.imageFromServerURL(urlString: movie.moviePosterPath)
        cell.movieTitle.text = movie.movieTitle
        cell.moviePopularity.text = "Popularity: \(movie.moviePopularity)"
        cell.selectionStyle = .none
        return cell
    }
}
