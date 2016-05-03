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
    
    
    func fetchRecentMovies(completion completion: (MovieResult) -> Void) {
        let url = "http://api.themoviedb.org/3/movie/now_playing?api_key=abef900e4db0bbaa6d4eb23f760ba53a"
        print(url)
        let NSURLValue = NSURLComponents(string: url)!
        let request = NSURLRequest(URL: NSURLValue.URL!)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processRecentMoviesRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processRecentMoviesRequest(data data: NSData?, error: NSError?) -> MovieResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return MovieAPI.moviesFromJSONData(jsonData)
    }
    
    func fetchDetailsForMovie(movie: Movie, completion: (MovieDetailsResult) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=abef900e4db0bbaa6d4eb23f760ba53a&append_to_response=releases,trailers"
        print(url)
        let NSURLValue = NSURLComponents(string: url)!
        let request = NSURLRequest(URL: NSURLValue.URL!)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processMovieDetailsRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processMovieDetailsRequest(data data: NSData?, error: NSError?) -> MovieDetailsResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return MovieAPI.movieDetailsJSONData(jsonData)
    }
    
    func fetchRatingsForMovie(movieDetails: MovieDetails, completion: (MovieRatingsResult) -> Void) {
        let url = "http://www.omdbapi.com/?i=\(movieDetails.imdb_id)&plot=short&r=json&tomatoes=true"
        let NSURLValue = NSURLComponents(string: url)!
        let request = NSURLRequest(URL: NSURLValue.URL!)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processMovieRatingsRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }

    
    
    func processMovieRatingsRequest(data data: NSData?, error: NSError?) -> MovieRatingsResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return MovieAPI.movieRatingsFromJSONData(jsonData)
    }
    
    func fetchSuggestionForMovie(movieDetails: MovieDetails, completion: (MovieResult) -> Void) {
        let url = "http://api.themoviedb.org/3/movie/\(movieDetails.id)/similar?api_key=abef900e4db0bbaa6d4eb23f760ba53a"
        print(url)
        let NSURLValue = NSURLComponents(string: url)!
        let request = NSURLRequest(URL: NSURLValue.URL!)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processRecentMoviesRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func searchForMovie(searchString: String, completion: (MovieResult) -> Void)
    {
        let url = "http://api.themoviedb.org/3/search/movie?query=\(searchString)&api_key=abef900e4db0bbaa6d4eb23f760ba53a"
        print(url)
        let NSURLValue = NSURLComponents(string: url)!
        let request = NSURLRequest(URL: NSURLValue.URL!)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processSearchMoviesRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processSearchMoviesRequest(data data: NSData?, error: NSError?) -> MovieResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return MovieAPI.moviesFromJSONData(jsonData)
    }
    
    func fetchImageForMovie(movie: Movie, completion: (ImageResult) -> Void) {
        
        if let image = movie.image {
            completion(.Success(image))
            return
        }
        
        let photoURL = "http://image.tmdb.org/t/p/w185/" + movie.posterpath
        let request = NSURLRequest(URL: NSURL(string: photoURL)!)
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
    
    func fetchImageForMovieDetails(movieDetail: MovieDetails, completion: (ImageResult) -> Void) {
        
        if let image = movieDetail.image {
            completion(.Success(image))
            return
        }
        
        let photoURL = "http://image.tmdb.org/t/p/w780/" + movieDetail.posterpath
        let request = NSURLRequest(URL: NSURL(string: photoURL)!)
        print(photoURL)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result {
                movieDetail.image = image
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
