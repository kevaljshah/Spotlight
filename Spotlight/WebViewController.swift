//
//  WebViewController.swift
//  Spotlight
//
//  Created by Akshay Iyer on 5/1/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//
import UIKit
import WebKit

class WebViewController: UIViewController
{
    var webView: UIWebView!
    var youtubeVideo: String!
    override func loadView() {
        webView = UIWebView()
        
        view = webView
    }
    
    override func viewWillAppear(animated: Bool) {
        print(youtubeVideo)
        
        let logoIcon: UIImage = UIImage(named: "SpotlightIcon.png")!
        self.navigationItem.titleView = UIImageView(image: logoIcon)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Load a web page into our web view */
        let url = NSURL(string: "https://www.youtube.com/embed/\(youtubeVideo)?autoplay=1")
        let urlRequest = NSURLRequest(URL: url!)
        webView.mediaPlaybackRequiresUserAction = false
        webView.allowsInlineMediaPlayback = true
        webView.loadRequest(urlRequest)
        
    }
}
