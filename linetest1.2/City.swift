//
//  City.swift
//  LINES
//
//  Created by david crabtree on 11/17/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import Foundation
import UIKit

class City: NSObject, NSCoding {
    
    //MARK: Properties
    var city: String
    var image: UIImage
    
    //MARK: Archiving Paths
    //static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    // static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ratings")
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cities")
    
    //MARK: Property key
    struct PropertyKey {
        static let city = "city"
        static let image = "image"
    }
    
    init?(city: String, image: UIImage) {
        
        self.city = city
        self.image = image
    }
    
    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(city, forKey: PropertyKey.city)
        
        aCoder.encode(image, forKey: PropertyKey.image)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let city = aDecoder.decodeObject(forKey: PropertyKey.city) as! String
        
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as! UIImage
        
        self.init(city: city, image: image)
    }
}
