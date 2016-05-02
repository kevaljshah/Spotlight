//
//  ImageCollectionController.swift
//  Spotlight
//
//  Created by Keval Shah on 4/12/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class ImageCollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    var movieStore: MovieStore!
 
    @IBOutlet var collectionView: UICollectionView!
    
    let movieDataSource = MovieDataSource()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.backItem?.title = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "Spotlight logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        collectionView.dataSource = movieDataSource
        collectionView.delegate = self
        movieStore.fetchRecentMovies() {
            (movieResult) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                switch movieResult {
                case let .Success(movies):
                    print("Successfully found \(movies.count) recent photos.")
                    self.movieDataSource.movies = movies
                case let .Failure(error):
                    self.movieDataSource.movies.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0))
            }
        
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSpacing = CGFloat(2) //Define the space between each cell
        let leftRightMargin = CGFloat(5) //If defined in Interface Builder for "Section Insets"
        let numColumns = CGFloat(3) //The total number of columns you want
        
        let totalCellSpace = cellSpacing * (numColumns - 1)
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height

        let width = (screenWidth - leftRightMargin - totalCellSpace) / numColumns
        let height = CGFloat(190 * (screenHeight/667.0)) //whatever height you want
        
        return CGSizeMake(width, height);
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let movie = movieDataSource.movies[indexPath.row]
        //Download the image data, which could take some time
        movieStore.fetchImageForMovie(movie) {
            (result) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                
                let movieIndex = self.movieDataSource.movies.indexOf(movie)!
                let movieIndexPath = NSIndexPath(forRow: movieIndex, inSection: 0)
                
                if let cell = self.collectionView.cellForItemAtIndexPath(movieIndexPath) as? MovieCollectionViewCell {
                    cell.updateWithImage(movie.image)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DataPass2" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first {
                let movie = movieDataSource.movies[selectedIndexPath.row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                let backItem = UIBarButtonItem()
                backItem.title = " "
                navigationItem.backBarButtonItem = backItem
                detailViewController.movieStore = movieStore
                detailViewController.movie = movie
            }
        }
    }
}