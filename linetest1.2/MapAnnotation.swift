//
//  MapAnnotation.swift
//  LINES
//
//  Created by david crabtree on 8/12/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import Foundation
import UIKit
/*
class Annotation: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    
    var details: String
    
    var Image: UIImage
    
    
    //MARK: Archiving Paths
    //static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    // static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ratings")
    
    //MARK: Property key
    struct PropertyKey {
        static let name = "name"
        
        static let details = "details"
        
        static let Image = "image"
        
    }
    
    
    init?(name: String, details: String, Image: UIImage) {
        
        self.name = name
        
        self.details = details
        
        self.Image = Image
    }
    
    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.name)
        
        aCoder.encode(details, forKey: PropertyKey.details)
        
        aCoder.encode(Image, forKey: PropertyKey.Image)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        
        let details = aDecoder.decodeObject(forKey: PropertyKey.details) as! String
        
        let image = aDecoder.decodeObject(forKey: PropertyKey.Image) as? UIImage
        
        self.init(name: name, details: details, Image: image!)
    }
}
 */
