//
//  DetailViewController.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/12/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet var buttonText: UIButton!
    @IBOutlet var likesCount: UILabel!
    var count: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likesCount.text = "45"
        count = 45
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
