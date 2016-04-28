//
//  MovieRatings.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/27/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class MovieRatings {
    let imdb_id: String
    let imdbRating: String
    let tomatoRating: String
    let metascore: String
    
    init(imdb_id: String, imdbRating: String, tomatoRating: String, metascore: String)
    {
        self.imdb_id = imdb_id
        self.imdbRating = imdbRating
        self.tomatoRating = tomatoRating
        self.metascore = metascore
    }
}

extension MovieRatings: Equatable {}

func == (lhs: MovieRatings, rhs: MovieRatings) -> Bool {
    return lhs.imdb_id == rhs.imdb_id
}