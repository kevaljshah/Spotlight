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
    @IBOutlet var likesCount: UILabel!
    var count: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likesCount.text = "45"
        count = 45
        //let vidWidth = trailerVid.wid
        //let vidHeight = trailerVid.height
        let youtubeLink:String = "https://www.youtube.com/embed/"
        let youtubeID: String = "7d_jQycdQGo"
        let finalLink: String = youtubeLink+youtubeID
        print(finalLink)
        let embedVid: NSString = "<iframe width=375 height=229 src=\(finalLink) frameborder=50 allowfullscreen></iframe>"
        print(embedVid)
        self.trailerVid.loadHTMLString(embedVid as String, baseURL: nil)
        trailerVid.scrollView.scrollEnabled = false;
        trailerVid.scrollView.bounces = false;
    }
    
    @IBAction func recommendButton(sender: UIButton) {
        let textToShare = "I would want you to check this movie out! Take a look: https://www.youtube.com/watch?v=7d_jQycdQGo"
        let shareText = [textToShare]
        let activityVC = UIActivityViewController(activityItems: shareText, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
            
            self.presentViewController(activityVC, animated: true, completion: nil)
    }
    @IBAction func addButton(sender: AnyObject) {
        
        if buttonText.currentTitle == "Like" {
            buttonText.setTitle("Dislike", forState: .Normal)
            count = count + 1
            likesCount.text = String(count)
        }
        else
        {
            buttonText.setTitle("Like", forState: .Normal)
            count = count - 1
            likesCount.text = String(count)
        }
        
    }
}
