//
//  WatchListDataSource.swift
//  Spotlight
//
//  Created by Keval Shah on 5/3/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit
class WatchListDataSource: NSObject, UICollectionViewDataSource {
    
    var watchListStore: WatchListStore!
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchListStore.allItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell5"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! WatchListCollectionViewCell
        
        let movie = watchListStore.allItems[indexPath.row]
        print(movie.id)
        cell.updateWithImage(movie.image)
        return cell
    }
}