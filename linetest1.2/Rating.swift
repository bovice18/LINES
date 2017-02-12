//
//  Rating.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import Foundation
import UIKit

class rating: NSObject, NSCoding {
    
    //MARK: Properties
    var slider: Int
    var lineRating: Int
    var time: String
    var comments: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ratings")
    
    
    //MARK: Property key
    struct PropertyKey {
        static let time = "time"
        static let lineRating = "lineRating"
        static let comments = "comments"
        static let slider = "slider"
    }
    
    // initialize
    init(time: String, lineRating: Int, slider: Int, comments: String){
        self.time = time
        self.comments = comments
        self.lineRating = lineRating
        self.slider = slider
    
        
    }

    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(comments, forKey: PropertyKey.comments)
        aCoder.encode(lineRating, forKey: PropertyKey.lineRating)
        aCoder.encode(slider, forKey: PropertyKey.slider)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let time = aDecoder.decodeObject(forKey: PropertyKey.time) as! String
        let comments = aDecoder.decodeObject(forKey: PropertyKey.comments) as! String
        let slider = aDecoder.decodeInteger(forKey:  PropertyKey.slider)
        let lineRating = aDecoder.decodeInteger(forKey: PropertyKey.lineRating)
        
        self.init(time: time, lineRating: lineRating, slider: slider, comments: comments)
        
    }
}
