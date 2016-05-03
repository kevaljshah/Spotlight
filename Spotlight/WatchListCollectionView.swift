//
//  WatchListCollectionView.swift
//  Spotlight
//
//  Created by Akshay Iyer on 5/3/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit
class WatchListCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet var collectionView: UICollectionView!
    
    var watchListStore: WatchListStore!
    var movieStore: MovieStore!
    let watchListSource = WatchListDataSource()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.backItem?.title = nil
        
        let logoIcon: UIImage = UIImage(named: "Watchlist.png")!
        self.navigationItem.titleView = UIImageView(image: logoIcon)
        print(watchListStore.allItems.count)
        collectionView.dataSource = watchListSource
        collectionView.delegate = self
        watchListSource.watchListStore = watchListStore
        collectionView.reloadSections(NSIndexSet(index: 0))

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
        
        let movie = watchListStore.allItems[indexPath.row]
        //Download the image data, which could take some time
        watchListStore.fetchImageForMovie(movie) {
            (result) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                
                let movieIndex = self.watchListSource.watchListStore.allItems.indexOf(movie)!
                let movieIndexPath = NSIndexPath(forRow: movieIndex, inSection: 0)
                
                if let cell = self.collectionView.cellForItemAtIndexPath(movieIndexPath) as? WatchListCollectionViewCell {
                    cell.updateWithImage(movie.image)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DataPass5" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first {
                let watchlist = watchListStore.allItems[selectedIndexPath.row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                let backItem = UIBarButtonItem()
                backItem.title = " "
                navigationItem.backBarButtonItem = backItem
                let movie = Movie(id: watchlist.id, posterpath: watchlist.posterpath)
                detailViewController.movie = movie
                detailViewController.movieStore = movieStore
                
            }
        }
    }
    
}
