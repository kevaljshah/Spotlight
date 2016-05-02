//
//  SuggestionDataSource.swift
//  Spotlight
//
//  Created by Akshay Iyer on 5/1/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class SuggestionDataSource: NSObject, UICollectionViewDataSource {
    
    var movies = [Movie]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell2"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! SuggestionCollectionViewCell
        
        let movie = movies[indexPath.row]
        cell.updateWithImage(movie.image)
        return cell
    }
}
