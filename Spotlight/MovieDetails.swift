//
//  MovieDetails.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/27/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class MovieDetails {
    let id: Int
    let posterpath: String
    let imdb_id: String
    let original_title: String
    let overview: String
    let release_date: String
    let youtubeLink: String
    var image: UIImage?
    
    init(id: Int, posterpath: String, imdb_id: String, original_title: String, overview: String, release_date: String, youtubeLink: String)
    {
        self.id = id
        self.posterpath = posterpath
        self.imdb_id = imdb_id
        self.original_title = original_title
        self.overview = overview
        self.release_date = release_date
        self.youtubeLink = youtubeLink
    }
}

extension MovieDetails: Equatable {}

func == (lhs: MovieDetails, rhs: MovieDetails) -> Bool {
    return lhs.id == rhs.id
}