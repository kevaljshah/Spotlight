//
//  DetailViewController.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/12/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit
import ContactsUI

class DetailViewController: UIViewController, CNContactPickerDelegate, UICollectionViewDelegate
{
    @IBOutlet var trailerVid: UIWebView!
    @IBOutlet var buttonText: UIButton!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieSynposis: UITextView!
    @IBOutlet var movieReleaseDate: UILabel!
    @IBOutlet var imdbRating: UILabel!
    @IBOutlet var tomatoesRating: UILabel!
    @IBOutlet var metaScore: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var watchListButton: UIButton!
    
    var count: Int!
    var movie: Movie!
    var movieStore: MovieStore!
    var watchListStore: WatchListStore!
    var youtubeVideo: String!
    var index: Int = 0
    let suggestionDataSource = SuggestionDataSource()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.backItem?.title = nil
        collectionView.dataSource = suggestionDataSource
        collectionView.delegate = self
        movieStore.fetchDetailsForMovie(movie) {
             (movieDetailsResult) -> Void in
        
            switch movieDetailsResult {
                case let .Success(movieDetail):
                    print("Successfully found \(movieDetail.id) recent photos.")
                self.movieStore.fetchImageForMovieDetails(movieDetail) {
                        (result) -> Void in
                        self.imageView.image = movieDetail.image
                        print(movieDetail.image)
                    }
                self.movieStore.fetchSuggestionForMovie(movieDetail) { (movieResult) -> Void in
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                        switch movieResult {
                        case let .Success(movies):
                                print("Successfully found \(movies.count) films")
                            self.suggestionDataSource.movies = movies
                        case let .Failure(error):
                                print("\(error)")
                            self.suggestionDataSource.movies.removeAll()
                        }
                        self.collectionView.reloadSections(NSIndexSet(index: 0))
                }
                }
                    
                self.movieStore.fetchRatingsForMovie(movieDetail) { (movieRatingResult) -> Void in
                            switch movieRatingResult {
                                case let .Success(movieRating):
                                         NSOperationQueue.mainQueue().addOperationWithBlock {
                                          
                                            self.navigationItem.title = nil
                                            self.movieTitle.text = movieDetail.original_title
                                            self.movieSynposis.text = movieDetail.overview
                                            self.movieReleaseDate.text = movieDetail.release_date
                                            self.imdbRating.text = movieRating.imdbRating
                                            self.tomatoesRating.text = movieRating.tomatoRating
                                            self.metaScore.text = movieRating.metascore
                                            self.youtubeVideo = movieDetail.youtubeLink
                            }
                                case let .Failure(error):
                                        print("Error fetching xyz recent photos: \(error)")
                        }
                    }
                case let .Failure(error):
                    print("Error fetchingggg recent photos: \(error)")
            }
        }
    
    }

    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let movie = suggestionDataSource.movies[indexPath.row]
        //Download the image data, which could take some time
        movieStore.fetchImageForMovie(movie) {
            (result) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                
                let movieIndex = self.suggestionDataSource.movies.indexOf(movie)!
                let movieIndexPath = NSIndexPath(forRow: movieIndex, inSection: 0)
                
                if let cell = self.collectionView.cellForItemAtIndexPath(movieIndexPath) as? SuggestionCollectionViewCell {
                    cell.updateWithImage(movie.image)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DataPass3" {
                let webViewController = segue.destinationViewController as! WebViewController
                webViewController.youtubeVideo = youtubeVideo
            }
        if segue.identifier == "DataPass5" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first {
                let movieSelected = suggestionDataSource.movies[selectedIndexPath.row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                let backItem = UIBarButtonItem()
                backItem.title = " "
                navigationItem.backBarButtonItem = backItem
                print("Data Passed")
                detailViewController.movieStore = movieStore
                detailViewController.watchListStore = watchListStore
                detailViewController.movie = movieSelected
            }
        }

    }
    
    @IBAction func addToWatchlist(sender: AnyObject)
    {
        let movieID = movie.id
        let movieposterpath = movie.posterpath
        //let newitem = WatchList(id: movieID, posterpath: movieposterPath)
        watchListStore.createItem(movieID, posterpath: movieposterpath)
        watchListButton.setTitle("Added to WatchList", forState: .Normal)
        let secondTab = self.tabBarController?.viewControllers?[2] as? UINavigationController
        let thirdTab = secondTab?.topViewController as? WatchListCollectionView
        print(secondTab)
        thirdTab!.watchListStore = watchListStore
        thirdTab!.movieStore = movieStore
        print(watchListStore.allItems.count)
    }
    
    @IBAction func recommendButton(sender: UIButton)
    {
        let textToShare = "I would want you to check this movie out! Take a look at \(movieTitle.text!  as String). YouTube Trailer: https://www.youtube.com/watch?v=\(youtubeVideo! as String)"
        let shareText = [textToShare]
        let activityshare = UIActivityViewController(activityItems: shareText, applicationActivities: nil)
            
            activityshare.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeOpenInIBooks]
            
            self.presentViewController(activityshare, animated: true, completion: nil)
    }
    
}
