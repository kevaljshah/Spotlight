//
//  MovieStore.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/23/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class MovieStore {
    
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
    
    func processRecentMoviesRequest(data data: NSData?, error: NSError?) -> MovieResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return MovieAPI.tomatoesFromJSONData(jsonData)
    }
    
    func fetchImageForMovie(movie: Movie, completion: (ImageResult) -> Void) {
        
        if let image = movie.image {
            completion(.Success(image))
            return
        }
        
        let photoURL = movie.imageURL
        let request = NSURLRequest(URL: photoURL)
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result {
                movie.image = image
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
    
    func fetchRecentPhotos(completion completion: (MovieResult) -> Void) {
        let url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=ws32mxpd653h5c8zqfvksxw9&limit=30"
        let NSURLValue = NSURLComponents(string: url)!
        let request = NSURLRequest(URL: NSURLValue.URL!)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processRecentMoviesRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
}
