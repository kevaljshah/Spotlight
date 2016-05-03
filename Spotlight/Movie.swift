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
    
    init(id: Int, posterpath: String)
    {
        self.id = id
        self.posterpath = posterpath
    }
}

extension Movie: Equatable {}

func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
}