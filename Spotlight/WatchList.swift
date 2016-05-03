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
    let id: Int
    var image: UIImage!
    let posterpath: String
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiveUrl = DocumentsDirectory.URLByAppendingPathComponent("watchlist")
    
    
    
    init(id: Int, posterpath: String) {
        self.id = id
        self.posterpath = posterpath
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(id, forKey: "id")
        aCoder.encodeObject(posterpath, forKey: "posterpath")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeIntegerForKey("id")
        let posterpath = aDecoder.decodeObjectForKey("posterpath") as! String
        
        self.init(id: id, posterpath: posterpath)
    }


}
