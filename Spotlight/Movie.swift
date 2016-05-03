//
//  Movie.swift
//  Spotlight
//
//  Created by Akshay Iyer on 4/23/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class Movie {
    let id: Int
    let posterpath: String
    var image: UIImage!
    var watchList: Bool
    
    init(id: Int, posterpath: String, watchList: Bool)
    {
        self.id = id
        self.posterpath = posterpath
        self.watchList = watchList
    }
}

extension Movie: Equatable {}

func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
}