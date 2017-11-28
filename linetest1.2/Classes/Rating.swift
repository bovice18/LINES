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
    var locationName: String
    
    var circleRating: Int
    
    var time: String
    
    var timeIntervalSinceNow: NSDate?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ratings")
    
    //MARK: Property key
    struct PropertyKey {
        static let locationName = "locationName"
        
        static let time = "time"
        static let circleRating = "circleRating"
        
        static let timeIntervalSinceNow = "timeIntervalSinceNow"
    }
    
    
    init?(locationName: String, time: String, circleRating: Int, timeIntervalSinceNow: NSDate?) {
        
        // The rating must be between 0 and 5 inclusively
        guard (circleRating >= 0) && (circleRating <= 5) else {
            return nil
        }
        
        self.locationName = locationName
        
        self.time = time
        
        self.circleRating = circleRating
        
        self.timeIntervalSinceNow = timeIntervalSinceNow
    }
    
    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(locationName, forKey: PropertyKey.locationName)
        
        aCoder.encode(time, forKey: PropertyKey.time)
        
        aCoder.encode(timeIntervalSinceNow, forKey: PropertyKey.timeIntervalSinceNow)
        
        aCoder.encode(circleRating, forKey: PropertyKey.circleRating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let locationName = aDecoder.decodeObject(forKey: PropertyKey.locationName) as! String
        
        let time = aDecoder.decodeObject(forKey: PropertyKey.time) as! String
        
        let circleRating = aDecoder.decodeInteger(forKey:  PropertyKey.circleRating)
        
        let timeIntervalSinceNow = aDecoder.decodeObject(forKey: PropertyKey.timeIntervalSinceNow) as? NSDate
        
        self.init(locationName: locationName, time: time, circleRating: circleRating, timeIntervalSinceNow: timeIntervalSinceNow)
    }
}
