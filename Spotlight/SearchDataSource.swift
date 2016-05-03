//
//  SearchDataSource.swift
//  Spotlight
//
//  Created by Keval Shah on 5/2/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class SearchDataSource: NSObject, UICollectionViewDataSource {
    
    var movies = [Movie]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell3"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! SearchCollectionViewCell
        
        let movie = movies[indexPath.row]
        cell.updateWithImage(movie.image)
        return cell
    }
}
