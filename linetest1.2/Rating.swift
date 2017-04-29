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
   // var locationIdentifier: Int
    var locationName: String
    var lineRating: Int?
    var circleRating: Int
    var time: String
    var comments: String
    var timeIntervalSinceNow: NSDate?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ratings")
    
    //MARK: Property key
    struct PropertyKey {
      //  static let locationIdentifier = "locationIdentifier"
        static let locationName = "locationName"
        static let time = "time"
        static let lineRating = "lineRating"
        static let comments = "comments"
        static let circleRating = "circleRating"
        static let timeIntervalSinceNow = "timeIntervalSinceNow"
    }
    
    // initialize
    init?(/*locationIdentifier: Int,*/locationName: String, time: String, lineRating: Int?, circleRating: Int, comments: String, timeIntervalSinceNow: NSDate?) {
        
        // The rating must be between 0 and 5 inclusively
        guard (circleRating >= 0) && (circleRating <= 5) else {
            return nil
        }
       // self.locationIdentifier = locationIdentifier
        self.locationName = locationName
        self.time = time
        self.comments = comments
        self.lineRating = lineRating
        self.circleRating = circleRating
        self.timeIntervalSinceNow = timeIntervalSinceNow
    }

    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
       // aCoder.encode(locationIdentifier, forKey: PropertyKey.locationIdentifier)
        aCoder.encode(locationName, forKey: PropertyKey.locationName)
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(comments, forKey: PropertyKey.comments)
        aCoder.encode(lineRating, forKey: PropertyKey.lineRating)
        aCoder.encode(timeIntervalSinceNow, forKey: PropertyKey.timeIntervalSinceNow)
        aCoder.encode(circleRating, forKey: PropertyKey.circleRating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
       // let locationIdentifier = aDecoder.decodeInteger(forKey:  PropertyKey.locationIdentifier)
        let locationName = aDecoder.decodeObject(forKey: PropertyKey.locationName) as! String
        let time = aDecoder.decodeObject(forKey: PropertyKey.time) as! String
        let comments = aDecoder.decodeObject(forKey: PropertyKey.comments) as! String
        let circleRating = aDecoder.decodeInteger(forKey:  PropertyKey.circleRating)
        let lineRating = aDecoder.decodeObject(forKey: PropertyKey.lineRating) as? Int
        let timeIntervalSinceNow = aDecoder.decodeObject(forKey: PropertyKey.timeIntervalSinceNow) as? NSDate
        
        self.init(/*locationIdentifier: locationIdentifier, */locationName: locationName, time: time, lineRating: lineRating, circleRating: circleRating, comments: comments, timeIntervalSinceNow: timeIntervalSinceNow)
    }
}
