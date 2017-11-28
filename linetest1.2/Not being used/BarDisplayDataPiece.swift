//
//  BarDisplayDataPiece.swift
//  LINES
//
//  Created by david crabtree on 5/12/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import Foundation

class BarDisplayDataPiece: NSObject {
    
    //MARK: Properties
    var waitTime: Int
    var postTime: String
    
    struct PropertyKey {
        
        static let waitTime = "waitTime"
        
        static let postTime = "postTime"
    }
    
    init?(waitTime: Int, postTime: String) {
        
        //Initialize stored properties
        self.waitTime = waitTime
        
        self.postTime = postTime
    }
    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(waitTime, forKey: PropertyKey.waitTime)
        
        aCoder.encode(postTime, forKey: PropertyKey.postTime)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let waitTime = aDecoder.decodeObject(forKey: PropertyKey.waitTime) as! Int
        
        let postTime = aDecoder.decodeObject(forKey: PropertyKey.postTime) as! String
        
        self.init(waitTime: waitTime, postTime: postTime)
    }
    
}




