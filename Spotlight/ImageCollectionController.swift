//
//  ImageCollectionController.swift
//  Spotlight
//
//  Created by Keval Shah on 4/12/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class ImageCollectionController: UIViewController, UICollectionViewDelegate
{
    var movieStore: MovieStore!
 
    @IBOutlet var collectionView: UICollectionView!
    
    let movieDataSource = MovieDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = movieDataSource
        collectionView.delegate = self
        movieStore.fetchRecentPhotos() {
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
                detailViewController.movieStore = movieStore
                detailViewController.movie = movie
            }
        }
    }
}