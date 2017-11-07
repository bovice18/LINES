//
//  Special.swift
//  LINES
//
//  Created by david crabtree on 7/17/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import Foundation
import UIKit

class Special: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var details: String
    
    
    //MARK: Archiving Paths
    //static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
   // static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ratings")
    
    //MARK: Property key
    struct PropertyKey {
        static let name = "name"
        static let details = "details"
        static let Image = "image"
        }
    
    
    init?(name: String, details: String) {
        
        self.name = name
        self.details = details
    }
    
    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.name)
        
        aCoder.encode(details, forKey: PropertyKey.details)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        
        let details = aDecoder.decodeObject(forKey: PropertyKey.details) as! String
    
        self.init(name: name, details: details)
    }
}
