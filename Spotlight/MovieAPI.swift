//
//  MovieAPI.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/23/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import Foundation

enum MovieResult {
    case Success([Movie])
    case Failure(ErrorType)
}

enum MovieDetailsResult {
    case Success(MovieDetails)
    case Failure(ErrorType)
}

enum MovieRatingsResult {
    case Success(MovieRatings)
    case Failure(ErrorType)
}

enum MovieError: ErrorType {
    case InvalidJSONData
}

struct MovieAPI {
    
    
    private static func moviesFromJSONObject(json: [String : AnyObject]) -> Movie? {
        guard let id = json["id"] as? Int,
            posterpath = json["poster_path"] as? String,
            watchList = false as? Bool
            else {
                //Don't have enough information to construct a Title
                return nil
        }
        print("Yay")
        //print(dateFormatter.dateFromString(json["release_dates"]!["theater"]))
        //print(json["ratings"]!["critics_score"])
        return Movie(id: id, posterpath: posterpath,watchList: watchList)
    }
    
    static func moviesFromJSONData(data: NSData) -> MovieResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let jsonDictionary = jsonObject as? [NSObject: AnyObject],
                moviesArray = jsonDictionary["results"] as? [[String: AnyObject]] else {
                    //The JSON Structure doesn't match our expectations
                    return .Failure(MovieError.InvalidJSONData)
            }
            var finalTomatoes = [Movie]()
            for movieJSON in moviesArray {
                if let movies = moviesFromJSONObject(movieJSON) {
                    finalTomatoes.append(movies)
                }
            }

            if finalTomatoes.count == 0 && moviesArray.count > 0 {
                //We weren't able to parse any of the movies
                //Maybe the JSON format for photos has changed
                print("Reached Here")
                return .Failure(MovieError.InvalidJSONData)
            }
            
            return .Success(finalTomatoes)
        }
        catch let error {
            return .Failure(error)
        }
    }
    
    static func movieDetailsJSONData(data: NSData) -> MovieDetailsResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            print(jsonObject)
            guard let jsonDictionary = jsonObject as? [NSObject: AnyObject],
                      trailers = jsonDictionary["trailers"]!["youtube"] as? [[NSObject: AnyObject]]
                else {
                    //The JSON Structure doesn't match our expectations
                    return .Failure(MovieError.InvalidJSONData)
            }

            var youtubeLink: String!
            var finalYoutubeLink: String!
            
            var posterpath1: String!
            var posterpath: String!
            
            guard let id = jsonDictionary["id"] as? Int,
                      imdb_id = jsonDictionary["imdb_id"] as? String,
                      original_title = jsonDictionary["original_title"] as? String,
                      overview = jsonDictionary["overview"] as? String,
                      release_date = jsonDictionary["release_date"] as? String
            else {
                return .Failure(MovieError.InvalidJSONData)
            }
            
            
            for youtubeTrailers in trailers {
                youtubeLink = youtubeTrailers["source"] as? String
            }
            
            if youtubeLink == nil {
                finalYoutubeLink = "Oi1BcouEmio"
            }
            else {
                finalYoutubeLink = youtubeLink
            }
            
            posterpath1 = jsonDictionary["backdrop_path"] as? String
            if posterpath1 == nil {
                posterpath = jsonDictionary["poster_path"] as? String
            }
            else {
                posterpath = posterpath1
            }
            
            let finalMovieDetails = MovieDetails(id: id, posterpath: posterpath, imdb_id: imdb_id, original_title: original_title, overview: overview, release_date: release_date, youtubeLink: finalYoutubeLink)
            
            print(finalMovieDetails)
            
            return .Success(finalMovieDetails)
        }
        catch let error {
            return .Failure(error)
        }
    }
    
     static func movieRatingsFromJSONData(data: NSData) -> MovieRatingsResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let jsonDictionary = jsonObject as? [NSObject: AnyObject]
            else {
                    //The JSON Structure doesn't match our expectations
                    return .Failure(MovieError.InvalidJSONData)
            }
            
            guard let imdb_id = jsonDictionary["imdbID"] as? String,
                imdbRating = jsonDictionary["imdbRating"] as? String,
                tomatoRating = jsonDictionary["tomatoRating"] as? String,
                metascore = jsonDictionary["Metascore"] as? String
                else {
                    return .Failure(MovieError.InvalidJSONData)
            }
        let finalMovieRatings = MovieRatings(imdb_id: imdb_id, imdbRating: imdbRating, tomatoRating: tomatoRating, metascore: metascore)
        
        return .Success(finalMovieRatings)
        }
        catch let error {
            return .Failure(error)
        }
        
    }
}
