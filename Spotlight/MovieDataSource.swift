//
//  MovieDataSource.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/23/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class MovieDataSource: NSObject, UICollectionViewDataSource {
    
    var movies = [Movie]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! MovieCollectionViewCell
        
        let movie = movies[indexPath.row]
        cell.updateWithImage(movie.image)
        return cell
    }
}
