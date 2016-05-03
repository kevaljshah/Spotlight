//
//  ViewController.swift
//  Spotlight
//
//  Created by Keval Shah on 4/10/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    
    var movieStore: MovieStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieStore.fetchRecentMovies() {
            (movieResult) -> Void in
            
            switch movieResult {
            case let .Success(movies):
                print("Successfully found \(movies.count) recent movies")
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DataPass1" {
           // let navigationController = segue.destinationViewController as! UINavigationController
            let tabBarController = segue.destinationViewController as! UITabBarController
            let navigationController = tabBarController.parentViewController as! UINavigationController
            let imageCollectionController = navigationController.topViewController as! ImageCollectionController
            imageCollectionController.movieStore = movieStore
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

