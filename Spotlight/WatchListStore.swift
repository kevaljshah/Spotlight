//
//  WatchListStore.swift
//  Spotlight
//
//  Created by Keval Shah on 5/3/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class WatchListStore {
    var allItems = [WatchList]()
    var image: UIImage!
    //var image: UIImage
    
    enum ImageResult {
        case Success(UIImage)
        case Failure(ErrorType)
    }
    
    enum PhotoError: ErrorType {
        case ImageCreationError
    }
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func createItem(id: Int, posterpath: String) -> WatchList {
        let newItem = WatchList(id: id, posterpath: posterpath)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(watchlist: WatchList) {
        if let index = allItems.indexOf(watchlist) {
            allItems.removeAtIndex(index)
        }
    }
    
    func fetchImageForMovie(watchList: WatchList, completion: (ImageResult) -> Void) {
        
        if let image = watchList.image {
            completion(.Success(image))
            return
        }
        
        let photoURL = "http://image.tmdb.org/t/p/w185/" + watchList.posterpath
        let request = NSURLRequest(URL: NSURL(string: photoURL)!)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result {
                watchList.image = image
            }
            
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data data: NSData?, error: NSError?) -> ImageResult {
        guard let
            imageData = data,
            image = UIImage(data: imageData) else {
                
                //Couldn't create an image
                if data == nil {
                    return .Failure(error!)
                }
                else {
                    return .Failure(PhotoError.ImageCreationError)
                }
        }
        return .Success(image)
    }
    
    
}
