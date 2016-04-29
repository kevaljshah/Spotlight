//
//  DetailViewController.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/12/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit
import ContactsUI

class DetailViewController: UIViewController, CNContactPickerDelegate
{
    @IBOutlet var trailerVid: UIWebView!
    @IBOutlet var buttonText: UIButton!
    var count: Int!
    
    var movie: Movie!    
    var movieStore: MovieStore!
    
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieSynposis: UITextView!
    @IBOutlet var movieReleaseDate: UILabel!
    
    @IBOutlet var imdbRating: UILabel!
    @IBOutlet var tomatoesRating: UILabel!
    @IBOutlet var metaScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.movieStore.fetchDetailsForMovie(self.movie) {
             (movieDetailsResult) -> Void in
                switch movieDetailsResult {
                case let .Success(movieDetail):
                    print("Successfully found \(movieDetail.id) recent photos.")
                    self.movieStore.fetchRatingsForMovie(movieDetail) {
                        (movieRatingResult) -> Void in
                        switch movieRatingResult {
                            case let .Success(movieRating):
                                NSOperationQueue.mainQueue().addOperationWithBlock {
                                    let youtubeLink:String = "https://www.youtube.com/embed/"
                                    let youtubeID = movieDetail.youtubeLink
                                    let finalLink: String = youtubeLink+youtubeID
                                    print(finalLink)
                                    let embedVid: NSString = "<iframe width=360 height=219.375 src=\(finalLink) frameborder=50 allowfullscreen></iframe>"
                                    print(embedVid)
                                    self.trailerVid.scrollView.scrollEnabled = false;
                                    self.trailerVid.scrollView.bounces = false;
                                    //trailerVid.scalesPageToFit = true;
                                    self.trailerVid.loadHTMLString(embedVid as String, baseURL: nil)
                                    
                                    self.navigationItem.title = movieDetail.original_title
                                    
                                    self.movieTitle.text = movieDetail.original_title
                                    self.movieSynposis.text = movieDetail.overview
                                    self.movieReleaseDate.text = movieDetail.release_date
                                    self.imdbRating.text = movieRating.imdbRating
                                    self.tomatoesRating.text = movieRating.tomatoRating
                                    self.metaScore.text = movieRating.metascore
                            }
                            case let .Failure(error):
                            print("Error fetching recent photos: \(error)")
                        }
                    }
                case let .Failure(error):
                    print("Error fetching recent photos: \(error)")
                }
            }
            //self.movieTitle.text = self.movie.title
            //self.movieYear.text = String(self.movie.year)
            //self.movieSynposis.text = self.movie.synopsis
            //self.movieReleaseDate.text = ("Release Date: ")+String(self.movie.releaseDate)
            //self.movieRating.text = String(self.movie.criticsRating) + ("%")


                //let vidWidth = trailerVid.wid
        //let vidHeight = trailerVid.height

    }

    
    @IBAction func recommendButton(sender: UIButton) {
        let textToShare = "I would want you to check this movie out! Take a look: https://www.youtube.com/watch?v=7d_jQycdQGo"
        let shareText = [textToShare]
        let activityshare = UIActivityViewController(activityItems: shareText, applicationActivities: nil)
            
            activityshare.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeOpenInIBooks]
            
            self.presentViewController(activityshare, animated: true, completion: nil)
    }
    
}
