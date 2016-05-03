//
//  SearchImageCollectionController.swift
//  Spotlight
//
//  Created by Keval Shah on 5/2/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class SearchImageCollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate
{
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchCollectionView: UICollectionView!
    
    var movieStore: MovieStore!
    var searchString: String = ""
    
    let searchDataSource = SearchDataSource()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.backItem?.title = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchString = searchBar.text! as String
        print(searchString)
        searchCollectionView.dataSource = searchDataSource
        searchCollectionView.delegate = self
        movieStore.searchForMovie(searchString) {
                                  (movieResult) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                switch movieResult {
                case let .Success(movies):
                    print("Successfully found \(movies.count) search movies.")
                    self.searchDataSource.movies = movies
                case let .Failure(error):
                    self.searchDataSource.movies.removeAll()
                    print("Error fetching search movies: \(error)")
                }
                self.searchCollectionView.reloadSections(NSIndexSet(index: 0))
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
        
        let movie = searchDataSource.movies[indexPath.row]
        //Download the image data, which could take some time
        movieStore.fetchImageForMovie(movie) {
            (result) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                
                let movieIndex = self.searchDataSource.movies.indexOf(movie)!
                let movieIndexPath = NSIndexPath(forRow: movieIndex, inSection: 0)
                
                if let cell = self.searchCollectionView.cellForItemAtIndexPath(movieIndexPath) as? SearchCollectionViewCell {
                    cell.updateWithImage(movie.image)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DataPass4" {
            if let selectedIndexPath = searchCollectionView.indexPathsForSelectedItems()?.first {
                let movieSelected = searchDataSource.movies[selectedIndexPath.row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                let backItem = UIBarButtonItem()
                backItem.title = " "
                navigationItem.backBarButtonItem = backItem
                print("Data Passed")
                detailViewController.movieStore = movieStore
                detailViewController.movie = movieSelected
            }
        }
    }
}