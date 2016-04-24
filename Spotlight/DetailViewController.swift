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
    
    var movie: Movie! {
        didSet {
            navigationItem.title = movie.title
        }
    }
    
    var movieStore: MovieStore!
    
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieSynposis: UITextView!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var movieReleaseDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.movieTitle.text = self.movie.title
            self.movieYear.text = String(self.movie.year)
            self.movieSynposis.text = self.movie.synopsis
            self.movieReleaseDate.text = self.movie.releaseDate
            self.movieRating.text = String(self.movie.criticsRating)
        }
        let youtubeLink:String = "https://www.youtube.com/embed/"
        let youtubeID: String = "7d_jQycdQGo"
        let finalLink: String = youtubeLink+youtubeID
        print(finalLink)
        let embedVid: NSString = "<iframe width=375 height=229 src=\(finalLink) frameborder=50 allowfullscreen></iframe>"
        print(embedVid)
        self.trailerVid.loadHTMLString(embedVid as String, baseURL: nil)
        trailerVid.scrollView.scrollEnabled = false;
        trailerVid.scrollView.bounces = false;
        //let vidWidth = trailerVid.wid
        //let vidHeight = trailerVid.height

    }
    
    @IBAction func recommendButton(sender: UIButton) {
        let textToShare = "I would want you to check this movie out! Take a look: https://www.youtube.com/watch?v=7d_jQycdQGo"
        let shareText = [textToShare]
        let activityVC = UIActivityViewController(activityItems: shareText, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
            
            self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
}
