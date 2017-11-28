//
//  LocationDetail.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class location {
    
    //MARK: Properties
    var locationName: String
    var locationNameLong: String
    var special: String
    var cityId: Int
    var cityName: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var locationId: Int
 //   var displayedPhoneNumber: String
    var recent: Int
    var recentTime: String
   // var ratings = [BarDisplayDataPiece]()
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("locations")
    
    //MARK: Property key
    struct PropertyKey {
        
        static let locationName = "locationName"
        static let locationNameLong = "locationNameLong"
        static let special = "special"
        static let cityId = "cityId"
        static let cityName = "cityName"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let locationId = "locationId"
        static let recent = "recent"
        static let recentTime = "recentTime"
        
    }
    
    //MARK: Initialization

    init?(locationName: String, locationNameLong: String, special: String, cityId: Int, cityName: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, locationId: Int, recent: Int, recentTime: String) {
    
    //Initialize stored properties
    self.locationName = locationName
    self.locationNameLong = locationNameLong
    self.special = special
    self.cityId = cityId
    self.cityName = cityName
    self.latitude = latitude
    self.longitude = longitude
    self.locationId = locationId
    self.recent = recent
    self.recentTime = recentTime
    }
    
    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
        aCoder.encode(locationName, forKey: PropertyKey.locationName)
        aCoder.encode(locationNameLong, forKey: PropertyKey.locationNameLong)
        aCoder.encode(special, forKey: PropertyKey.special)
        aCoder.encode(cityId, forKey: PropertyKey.cityId)
        aCoder.encode(cityName, forKey: PropertyKey.cityName)
        aCoder.encode(latitude, forKey: PropertyKey.latitude)
        aCoder.encode(longitude, forKey: PropertyKey.longitude)
        aCoder.encode(locationId, forKey: PropertyKey.locationId)
        aCoder.encode(recent, forKey: PropertyKey.recent)
        aCoder.encode(recentTime, forKey: PropertyKey.recentTime)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let locationName = aDecoder.decodeObject(forKey: PropertyKey.locationName) as! String
        let locationNameLong = aDecoder.decodeObject(forKey: PropertyKey.locationNameLong) as! String
        let special = aDecoder.decodeObject(forKey: PropertyKey.special) as! String
        let cityId = aDecoder.decodeObject(forKey: PropertyKey.cityId) as! Int
        let cityName = aDecoder.decodeObject(forKey: PropertyKey.cityName) as! String
        let latitude = aDecoder.decodeObject(forKey: PropertyKey.latitude) as! CLLocationDegrees
        let longitude = aDecoder.decodeObject(forKey: PropertyKey.longitude) as! CLLocationDegrees
        let locationId = aDecoder.decodeObject(forKey: PropertyKey.locationId) as! Int
        let recent = aDecoder.decodeObject(forKey: PropertyKey.recent) as? Int
        let recentTime = aDecoder.decodeObject(forKey: PropertyKey.recentTime) as! String
        
        self.init(locationName: locationName, locationNameLong: locationNameLong, special: special, cityId: cityId, cityName: cityName, latitude: latitude, longitude: longitude, locationId: locationId, recent: recent!, recentTime: recentTime)
    }
}
