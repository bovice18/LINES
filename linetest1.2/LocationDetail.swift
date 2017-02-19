//
//  LocationDetail.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import Foundation
import UIKit

class location {
    
    //MARK: Properties
    var detail1: String
    var detail2: String
    var ratingList: NSArray
    var locationImagine: UIImage
    var address: String
    var phoneNumber: String
    var displayedAddress: String
    var displayedPhoneNumber: String
    var llLocation: String
    var qLocation: String
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("locations")
    
    
    //MARK: Property key
    struct PropertyKey {
        static let detail1 = "detail1"
        static let detail2 = "detail2"
        static let ratingList = "ratingList"
        static let locationImagine = "locationImagine"
        static let address = "address"
        static let phoneNumber = "phoneNumber"
        static let displayedPhoneNumber = "displayedPhoneNumber"
        static let displayedAddress = "displayedAddress"
        static let llLocation = "llLocation"
        static let qLocation = "qLocation"
    }
    
    //MARK: Initialization

    init?(detail1: String, detail2: String, ratingList: NSArray, locationImagine: UIImage, address: String, phoneNumber: String, displayedAddress: String, displayedPhoneNumber: String, llLocation: String, qLocation: String) {
    
    //Initialize stored properties
    self.detail1 = detail1
    self.detail2 = detail2
    self.ratingList = ratingList
    self.locationImagine = locationImagine
    self.address = address
    self.phoneNumber = phoneNumber
    self.displayedAddress = displayedAddress
    self.displayedPhoneNumber = displayedPhoneNumber
    self.llLocation = llLocation
    self.qLocation = qLocation
    }
    
    //MARK: NSCoding:
    func encode(with aCoder: NSCoder) {
        aCoder.encode(detail1, forKey: PropertyKey.detail1)
        aCoder.encode(detail2, forKey: PropertyKey.detail2)
        aCoder.encode(ratingList, forKey: PropertyKey.ratingList)
        aCoder.encode(locationImagine, forKey: PropertyKey.locationImagine)
        aCoder.encode(address, forKey: PropertyKey.address)
        aCoder.encode(phoneNumber, forKey: PropertyKey.phoneNumber)
        aCoder.encode(displayedAddress, forKey: PropertyKey.displayedAddress)
        aCoder.encode(displayedPhoneNumber, forKey: PropertyKey.displayedPhoneNumber)
        aCoder.encode(llLocation, forKey: PropertyKey.llLocation)
        aCoder.encode(qLocation, forKey: PropertyKey.qLocation)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let detail1 = aDecoder.decodeObject(forKey: PropertyKey.detail1) as! String
        let detail2 = aDecoder.decodeObject(forKey: PropertyKey.detail2) as! String
        let ratingList = aDecoder.decodeObject(forKey: PropertyKey.ratingList) as! NSArray
        let locationImagine = aDecoder.decodeObject(forKey: PropertyKey.locationImagine) as! UIImage
        let address = aDecoder.decodeObject(forKey: PropertyKey.address) as! String
        let phoneNumber = aDecoder.decodeObject(forKey: PropertyKey.phoneNumber) as! String
        let displayedPhoneNumber = aDecoder.decodeObject(forKey: PropertyKey.displayedPhoneNumber) as! String
        let displayedAddress = aDecoder.decodeObject(forKey: PropertyKey.displayedAddress) as! String
        let llLocation = aDecoder.decodeObject(forKey: PropertyKey.llLocation) as! String
        let qLocation = aDecoder.decodeObject(forKey: PropertyKey.qLocation) as! String
        
        self.init(detail1: detail1, detail2: detail2, ratingList: ratingList, locationImagine: locationImagine, address: address, phoneNumber: phoneNumber, displayedAddress: displayedAddress, displayedPhoneNumber: displayedPhoneNumber, llLocation: llLocation, qLocation: qLocation)
    }
}
