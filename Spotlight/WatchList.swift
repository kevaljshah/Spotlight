//
//  WatchList.swift
//  Spotlight
//
//  Created by Keval Shah on 5/3/16.
//  Copyright © 2016 Keval Shah. All rights reserved.
//

import UIKit

class WatchList: NSObject, NSCoding
{
    var id: Int
    var poster: UIImage?
    var posterpath: String
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiveUrl = DocumentsDirectory.URLByAppendingPathComponent("watchlist")
    
    
    
    init?(id: Int, poster: UIImage?, posterpath: String) {
        self.id = id
        self.poster = poster
        self.posterpath = posterpath
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(id, forKey: "id")
        aCoder.encodeObject(poster, forKey: "poster")
        aCoder.encodeObject(posterpath, forKey: "posterpath")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeIntegerForKey("id")
        let poster = aDecoder.decodeObjectForKey("poster") as? UIImage
        let posterpath = aDecoder.decodeObjectForKey("posterpath") as! String
        
        self.init(id: id, poster: poster, posterpath: posterpath)
    }


}
