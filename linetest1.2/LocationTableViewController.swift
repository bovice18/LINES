
//
//  LocationTableViewController.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import os.log
import CoreLocation

class LocationTableViewController: UITableViewController, UISearchBarDelegate {
    
    var timer: Timer!
    
    @IBOutlet weak var ActivityView: UIView!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var loadingView: UIView!
    
    
    var locations = [location]()
    
    var location1ratings = [rating]()
    
    var ratings = [rating]()
    
    var ChipotleCircle = Int()
    
    var ChipotleTime = String()
    
    var CornerstoneCircle = Int()
    
    var CornerstoneTime = String()
    
    var TerrapinsTurfCircle = Int()
    
    var TerrapinsTurfTime = String()
    
    var McGarveysCircle = Int()
    
    var McGraveysTime = String()
    
    var PussersCircle = Int()
    
    var PussersTime = String()
    
    var BentleysCircle = Int()
    
    var BentleysTime = String()
    
    var AcmeCircle = Int()
    
    var AcmeTime = String()
    
    var MoesCircle = Int()
    
    var MoesTime = String()
    
    var RedBeanCirle = Int()
    
    var RedBeanTime = String()
    
    var AnnapolisIceCircle = Int()
    
    var AnnapolisIceTime = String()
    
    var JossCircle = Int()
    
    var JossTime = String()
    
    var CityDockCircle = Int()
    
    var CityDockTime: String?
    
    var IronCircle = Int()
    
    var IronTime = String()
    
    var DockStreetCircle = Int()
    
    var DockStreetTime = String()
    
    var StormBrosCircle = Int()
    
    var StormBrosTime = String()
    
    var StarbucksCircle = Int()
    
    var StarbucksTime = String()
    
    var chipotleRatings = [rating]()
    
    var potbellyRatings = [rating]()
    
    var cornerstoneRatings = [rating]()
    
    var bentleysRatings = [rating]()
    
    var terripansRatings = [rating]()
    
    
    /*
    var ChipotleDataPiece = [BarDisplayDataPiece]()
    
    var AcmeDataPiece = [BarDisplayDataPiece]()
    
    var McGarveysDataPiece = [BarDisplayDataPiece]()
    
    var MoesDataPiece = [BarDisplayDataPiece]()
    
    var PussersDataPiece = [BarDisplayDataPiece]()
    
    var JossDataPiece = [BarDisplayDataPiece]()
    
    var DockStreetDataPiece = [BarDisplayDataPiece]()
    
    var AnnapolisIceDataPiece = [BarDisplayDataPiece]()
    
    var CityDockCafeDataPiece = [BarDisplayDataPiece]()
    
    var IronRoosterDataPiece = [BarDisplayDataPiece]()
    
    var StarbucksDataPiece = [BarDisplayDataPiece]()
    
    var StormBrosDataPiece = [BarDisplayDataPiece]()
    
    var RedBeanDataPiece = [BarDisplayDataPiece]()
    */
    
    var locationList: [location] = [location]()
    
    var locationSearchingList: [location] = [location]()
    
    var AcmeSpecial = [Special]()
    
    //OLD WAY FOR GETTING SPECIALS
  /*  var aSpecial = Special(name: "MONDAY", details: "$3 Domestic Bottles - $3 Craft Beers", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial1 = Special(name: "SUNDAY", details: "$10 Select Bottles of Wine - $3 Select Vodka Drinks - $3 Craft Beers", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial2 = Special(name: "TUESDAY", details: "$3 Select Vodka Shots - $3 Domestic Beers ", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial3 = Special(name: "WEDNESDAY", details: "$4 Vodka Drinks (ladies only) - $3 Domestic Bottles", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial4 = Special(name: "THURSDAY", details: "$4 Vodka Drinks (ladies only) - $3 Domestic Bottles", Image: #imageLiteral(resourceName: "acme1"))
  */
    
    func NewDataLoad2() {
        
        
        
        let currentLocation = UserDefaults.standard.value(forKey: "CurrentLocation") as! String
        print("current location")
        print(currentLocation)
        
        let newCurrentLocation = currentLocation.replacingOccurrences(of: " ", with: "_")
        print(newCurrentLocation)
        
       // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let scriptURL = "http://waitmatehq.com/testData.php?\(newCurrentLocation)"
        
        // Add one parameter
        let urlWithParams = scriptURL
        
        print("URL")
        print(urlWithParams)
        let myUrl = NSURL(string: urlWithParams);
     //  print(myUrl)
        let request = NSMutableURLRequest(url: myUrl as! URL);
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            print("newloaddata")
            
            
            if let array = json as? [Any] {
                /*
                if let firstObject = array.first {
                    print("data here")
                    print(firstObject)
                    if let dictionary = firstObject as? [String: Any] {
                        print("inside here")
                        print(dictionary)
                        if let number = dictionary["locationName"] as? String {
                            // access individual value in dictionary
                            print(number)
                        }
                        if let number = dictionary["recent"] as? String {
                            // access individual value in dictionary
                            print(number)
                        }
                        if let number = dictionary["lastUpdated"] as? String {
                            // access individual value in dictionary
                            print(number)
                        }
                        if let nestedDictionary = dictionary["estimated"] as? [String: Any] {
                            print(nestedDictionary)
                            print("nested here")
                            if let number = nestedDictionary["17"] as? String {
                                // access individual value in dictionary
                                print(number)
                            }
                    }
                    }
                    //print(firstObject)
                    // access individual object in array
                */
            for object in array {
                    // access all objects in array
                /*
                guard let dictionary = firstobject as? [String: Any] else {
                    
                    print("error")
                    return
                }
                
                guard let circleRating = dictionary["circleRating"] as? String,
                    let Time = dictionary["timeDate"] as? String,
                    let location = dictionary["locationName"] as? String
                    else {
                        print("error")
                        return
                }
 */

                guard let dictionary = object as? [String: Any] else {
                    print("error")
                    return
                }
                    print("inside here")
                    print(dictionary)
                    
                guard let name = dictionary["locationName"] as? String,
                    let recent = dictionary["recent"] as? String,
                    let lastUpdated = dictionary["lastUpdated"] as? String,
                    let specials = dictionary["specials"] as? String,
                    let longitude = dictionary["longitude"] as? Double,
                    let latitude = dictionary["latitude"] as? Double,
                    let longName = dictionary["longName"] as? String
                    else {
                        print("error")
                        return
                }
                
                var recentTime = String()
          if lastUpdated != "" {
                //Setting date formatter
                let dateFormatter = DateFormatter()
                //setting the sytle for the date
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                //setting the recent time to the date format
                let date1 = dateFormatter.date(from: lastUpdated)!
                //taking the interval from the date formatted date
                let TimeNow = date1.timeIntervalSinceNow
                //making it a positive number instead of negative/ making it back to a string from a time interval
                 recentTime = self.stringFromTimeInterval(interval: TimeNow * -1)
                }
          else {
                recentTime = ""
                }
                let numberRecent = Int(recent)
                let lat = CLLocationDegrees(latitude)
                let long = CLLocationDegrees(longitude)
                
                guard let Acme = location(locationName: name, locationNameLong: longName, special: specials, cityId:
                    0, cityName: "", latitude: lat, longitude: long, locationId: 0, recent: numberRecent!, recentTime:
                    recentTime) else {
                    fatalError("Unable to instantiate location2")
                }
                DispatchQueue.main.async() {  self.locations.append(Acme) }
                DispatchQueue.main.async() { self.tableView.reloadData() }
                
             //   DispatchQueue.main.async() { self.tableView.reloadData() }
                DispatchQueue.main.async() { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
            }
        }
            
    
        
        do {
            //   if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
            
            // Print out dictionary
            // print(convertedJsonIntoDict)
            
            // Get value by key
            //  let firstNameValue = convertedJsonIntoDict["locationName"] as? String
            //   print(firstNameValue!)
            
            // }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    task.resume()
    }
    
    /*

    let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
    
    func NewLoadData() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getDataNew.php"
        
        // Add one parameter
        let urlWithParams = scriptURL
        
        let myUrl = NSURL(string: urlWithParams);
        
        let request = NSMutableURLRequest(url: myUrl as! URL);
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            //
            if let dictionary = json as? [String: Any] {
                //
                if let nestedDictionary = dictionary["Acme"] as? [String: Any] {
                    // access nested dictionary values by key
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.AcmeCircle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            self.AcmeTime = TimeSincePost
                
                            print(self.AcmeTime)
                        } else {
                            self.AcmeTime = lastupdated
                        }
                    }
                }
                
                if let nestedDictionary = dictionary["McGarveys"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.McGarveysCircle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            
                            self.McGraveysTime = TimeSincePost
                            print("mcgraveys time is here")
                            print(self.McGraveysTime)
                        } else {
                            self.McGraveysTime = lastupdated
                        }
                    }
                }
                
                
                if let nestedDictionary = dictionary["Armadillos"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.RedBeanCirle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            
                            self.RedBeanTime = TimeSincePost
                        } else {
                            self.RedBeanTime = lastupdated
                        }
                    }
                }
                
                
                if let nestedDictionary = dictionary["Dock Street"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.DockStreetCircle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            
                            self.DockStreetTime = TimeSincePost
                        } else {
                            self.DockStreetTime = lastupdated
                        }
                    }
                }
                
                
                if let nestedDictionary = dictionary["Pussers"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.PussersCircle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            
                            self.PussersTime = TimeSincePost
                        } else {
                            self.PussersTime = lastupdated
                        }
                    }
                }
                
                
                if let nestedDictionary = dictionary["Federal House"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.ChipotleCircle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            
                            self.ChipotleTime = TimeSincePost
                        } else {
                            self.ChipotleTime = lastupdated
                        }
                    }
                }
                if let nestedDictionary = dictionary["Bentleys"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.BentleysCircle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            
                            self.BentleysTime = TimeSincePost
                        } else {
                            self.BentleysTime = lastupdated
                        }
                    }
                }
                if let nestedDictionary = dictionary["Terrapins Turf"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.TerrapinsTurfCircle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            
                            self.TerrapinsTurfTime = TimeSincePost
                        } else {
                            self.TerrapinsTurfTime = lastupdated
                        }
                    }
                }
                if let nestedDictionary = dictionary["Cornerstone"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.CornerstoneCircle = Int(recent)!
                    }
                    
                    if let lastupdated = nestedDictionary["lastUpdated"] as? String {
                        print("last updated")
                        print(lastupdated)
                        
                        if lastupdated != "" {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = dateFormatter.date(from: lastupdated)!
                            
                            let TimeNow = date1.timeIntervalSinceNow
                            let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                            
                            self.CornerstoneTime = TimeSincePost
                        } else {
                            self.CornerstoneTime = lastupdated
                        }
                    }
                }
                switch self.navigationItem.title! {
                case "Annapolis, MD":
                    print("Annapolis")
                    self.sampleLocations()
                case "College Park, MD":
                    print("College Park, MD")
                    self.sampleLocationsCP()
                default:
                    print("No location selected")
                }
                
                
               // self.sampleLocations()
                DispatchQueue.main.async() { self.tableView.reloadData() }
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
        }
            
            // Convert server json response to NSDictionary
            do {
                //   if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                
                // Print out dictionary
                // print(convertedJsonIntoDict)
                
                // Get value by key
                //  let firstNameValue = convertedJsonIntoDict["locationName"] as? String
                //   print(firstNameValue!)
                
                // }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
    
        task.resume()
      
    }
    */
    /*
    
    private func loadData1() {
        
        var task: URLSessionDataTask
        
        // Add one parameter
        let urlWithParams = scriptURL
        
        let myUrl = NSURL(string: urlWithParams);
        
        let request = NSMutableURLRequest(url: myUrl! as URL);
        
        request.httpMethod = "GET"
        
        task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            
            print("working")
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            guard let array = json as? [Any] else {
                print("error")
                return
            }
            
            for firstobject in array {
                
                guard let dictionary = firstobject as? [String: Any] else {
                    
                    print("error")
                    return
                }
                
                guard let circleRating = dictionary["circleRating"] as? String,
                    let Time = dictionary["timeDate"] as? String,
                    let location = dictionary["locationName"] as? String
                    else {
                        print("error")
                        return
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date1 = dateFormatter.date(from: Time)!
                
                let TimeNow = date1.timeIntervalSinceNow
                let TimeSincePost = self.stringFromTimeInterval(interval: TimeNow * -1)
                
                
                dateFormatter.dateFormat = "HH"
                let dateString = dateFormatter.string(from: date1 )
                print(dateString)
                
                let dataPiece = BarDisplayDataPiece(waitTime: 0, postTime: "")
                
                print("after")
                
                let name = location
                
                switch name {
                    
                case "Federal House":
                    
                    self.ChipotleTime = TimeSincePost
                    
                    self.ChipotleCircle = Int(circleRating)!
                    print(circleRating)
                    print(self.ChipotleCircle)
                    
                    dataPiece?.waitTime = Int(circleRating)!
                    
                    dataPiece?.postTime = dateString
                    
                    self.ChipotleDataPiece.append(dataPiece!)
                    
                    print(self.ChipotleDataPiece)
                    
                    print("array")
                    
                    print(self.ChipotleDataPiece.count)
                    
                    print(self.ChipotleDataPiece.first?.postTime as Any)
                    
                    print("after")
                    
                case "McGarveys":
                    
                    self.McGarveysDataPiece.removeAll()
                    
                    self.McGarveysCircle = Int(circleRating)!
                    
                    self.McGraveysTime = TimeSincePost
                    
                    dataPiece?.waitTime = Int(circleRating)!
                    
                    dataPiece?.postTime = dateString
                    
                    self.McGarveysDataPiece.append(dataPiece!)
                    
                    print(self.McGarveysDataPiece)
                    
                    print("array")
                    
                    print(self.McGarveysDataPiece.count)
                    
                    print("Acme")
                    
                case "Acme":
                    
                    self.AcmeCircle = Int(circleRating)!
                    
                    self.AcmeTime = TimeSincePost
                    
                    dataPiece?.waitTime = Int(circleRating)!
                    
                    dataPiece?.postTime = dateString
                    
                    self.AcmeDataPiece.append(dataPiece!)
                    
                    print(self.AcmeDataPiece)
                    
                    print("array")
                    
                    print(self.AcmeDataPiece.count)
                    
                case "Pussers":
                    
                    self.PussersCircle = Int(circleRating)!
                    
                    self.PussersTime = TimeSincePost
                    
                    dataPiece?.waitTime = Int(circleRating)!
                    
                    dataPiece?.postTime = dateString
                    
                    self.PussersDataPiece.append(dataPiece!)
                    
                    print(self.PussersDataPiece)
                    
                    print("array")
                    
                    print(self.PussersDataPiece.count)
                    
                case "Armadillos":
                    
                    self.RedBeanCirle = Int(circleRating)!
                    
                    self.RedBeanTime = TimeSincePost
                    
                    dataPiece?.waitTime = Int(circleRating)!
                    
                    dataPiece?.postTime = dateString
                    
                    self.RedBeanDataPiece.append(dataPiece!)
                    
                    print(self.RedBeanDataPiece)
                    
                    print("array")
                    
                    print(self.RedBeanDataPiece.count)
      
                    
                case "Dock Street":
                    
                    self.DockStreetCircle = Int(circleRating)!
                    
                    self.DockStreetTime = TimeSincePost
                    
                    dataPiece?.waitTime = Int(circleRating)!
                    
                    dataPiece?.postTime = dateString
                    
                    self.DockStreetDataPiece.append(dataPiece!)
                    
                    print(self.DockStreetDataPiece)
                    
                    print("array")
                    
                    print(self.DockStreetDataPiece.count)
                    
                default:
                    
                    print("error")
     }
            }
            
            guard let firstObject = array.last else {
                print("error")
                return
            }
            
            //    self.sampleLocations()
            self.tableView.reloadData()
            //    self.tableView.reloadData()
        }
        task.resume()
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      //  UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
       // self.navigationController?.navigationBar.isTranslucent = true
        //self.navigationController?.view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1647058824, blue: 0.8470588235, alpha: 1)
        
        if UserDefaults.standard.value(forKey: "CurrentLocation") != nil {
            navigationItem.title = UserDefaults.standard.value(forKey: "CurrentLocation") as! String
            NewDataLoad2()
            
        }
        //previous way we determined location/navigaiton title
        /*
        switch UserDefaults.standard.integer(forKey: "locationSelected") {
        case 0:
            print("Annapolis")
            navigationItem.title = "Annapolis, MD"
        case 1:
            print("College Park")
            navigationItem.title = "College Park, MD"
        default:
            print("no location selected")
        }
 */
        
        LocationSelected()
        
        // let tap = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
        //  tap.delegate = (self as! UIGestureRecognizerDelegate)
        // tableView.addGestureRecognizer(tap)
        
        refreshControl = UIRefreshControl()
        
        tableView.addSubview(refreshControl!)
        
        tableView.scrollsToTop = true
        
        ActivityView.isHidden = false
        
        //  ActivityView.isOpaque = true
        
        ActivityIndicator.startAnimating()
        
        timer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(endLoading), userInfo: nil, repeats: false)
        
        // AcmeSpecial = [aSpecial!,aSpecial1!,aSpecial2!,aSpecial3!,aSpecial4!]
        
        //loadData1()
       // NewLoadData()
        // tableView.reloadData()
        
        print(chipotleRatings)
        
        let currentDate = NSDate()
        
        print(currentDate)
        
        locationList = locations
    }
 
    
    override func viewDidAppear(_ animated: Bool) {
        
        //locations.count
        
        switch navigationItem.title! {
        case "Annapolis, MD":
            print("Annapolis")
         //   self.sampleLocations()
        case "College Park, MD":
            print("College Park, MD")
          //  self.sampleLocationsCP()
        default:
            print("No location selected")
        }
        
        handleTap()
        tableView.reloadData()
        // sampleLocations()
        // loadData1()
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row]
        
        return locations.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Location"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LocationTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let location = locations[indexPath.row]
        
        
        cell.detail1Lbl.text = location.locationNameLong
        
        if location.special != "" {
            
            cell.timeSinceLastPostLbl.text = "SPECIALS"

        } else {
            cell.timeSinceLastPostLbl.text = ""
        }
        
        //cell.timeSinceLastPostLbl.text = location.recentTime
        
        switch location.recent {
            
        case 0:
            
            cell.minutesLabel.text = "0-5m"
            
            cell.arrowImage.image = UIImage(named: "0-5")
            
        case 1:
            
            cell.minutesLabel.text = "0-5m"
            
            cell.arrowImage.image = UIImage(named: "0-5")
            
        case 2:
            
            cell.minutesLabel.text = "5-10m"
            
            cell.arrowImage.image = UIImage(named: "5-10")
            
        case 3:
            
            cell.minutesLabel.text = "10-20m"
            
            cell.arrowImage.image = UIImage(named: "10-20")
            
        case 4:
            
            cell.minutesLabel.text = "20m+"
            
            cell.arrowImage.image = UIImage(named: "20+")
            
        default:
            print("error")
        }
        
        return cell
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
      //  UIButton.appearance().setTitleColor(UIColor.green, for: UIControlState.normal)
        
        let postAction = UITableViewRowAction(style: .normal, title: "          ") { (action: UITableViewRowAction!, indexPath: IndexPath!) -> Void in
            
            let firstActivityAction = self.locations[indexPath.row]
            
            var request = URLRequest(url: URL(string: "http://waitmatehq.com/insertTest.php")!)
            
            request.httpMethod = "POST"
            
            
            let postString = "Location_Name=\(firstActivityAction.locationName)"+"&Circle_Rating=\(firstActivityAction.recent)"
            
            request.httpBody = postString.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            
            task.resume()
            
            self.performSegue(withIdentifier: "Confirmed", sender: indexPath)
            
            let indexPath1 = [indexPath]
            
        }
      //  let postAction2 = UITableViewRowAction(style: .normal, title: "             ") { (action: UITableViewRowAction!, indexPath: IndexPath!) -> Void in
        
        let postAction2 = UITableViewRowAction(style: .normal, title: "             ") { (action: UITableViewRowAction!, indexPath: IndexPath!) -> Void in

            
            let firstActivityAction2 = self.locations[indexPath.row]
            
            let activityViewController = UIActivityViewController(activityItems: [firstActivityAction2, firstActivityAction2], applicationActivities: nil)
            
            self.performSegue(withIdentifier: "JoinTheLine", sender: indexPath)
            
        }
        
        let confirmationImage = UIImage(named: "confirmationIcon")
        
        let rect = CGRect(x: 0, y: 0, width: 33, height: 132)
        
        #imageLiteral(resourceName: "confirmationIcon").drawAsPattern(in: rect)
        
        postAction.backgroundColor = UIColor(patternImage: confirmationImage!)
        
        postAction2.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "joinTheLine"))
        
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return [postAction, postAction2]
    }
    
    @objc private func removeToolBar() {
        self.navigationController?.isToolbarHidden
            = true
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail":
            guard let locationDetailViewController = segue.destination as? LocationDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedLocationCell = sender as? LocationTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedLocationCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let PostViewController = RatingViewController()
            
            
            let selectedLocation = locations[indexPath.row]
            
            PostViewController.Location = selectedLocation
            
            locationDetailViewController.Location = selectedLocation
            
            locationDetailViewController.directPost = 0
            
            UserDefaults.standard.set(selectedLocation.locationName, forKey: "BarSelected")
            UserDefaults.standard.set(selectedLocation.locationNameLong, forKey: "LongNameSelected")
            UserDefaults.standard.synchronize()
            
        case "JoinTheLine":
            
            guard let locationDetailViewController = segue.destination as? LocationDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let button = sender as? IndexPath else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let firstActivityAction = self.locations[button.row]
            
            let selectedLocation = locations[button.row]
            
            locationDetailViewController.Location = selectedLocation
            
            locationDetailViewController.directPost = 1
            
            UserDefaults.standard.set(selectedLocation.locationName, forKey: "BarSelected")
            UserDefaults.standard.set(selectedLocation.locationNameLong, forKey: "LongNameSelected")
            UserDefaults.standard.synchronize()
            
        case "Confirmation":
            
            print("Line Confirmed")
            
        case "Confirmed":
            
            print("line is confirmed")
            
        case "Back":
            print("back was pressed")
            
        case "Map":
            print("Map")
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    /*
    func sampleLocations() {
        
        guard let Acme = location(detail1: "Acme Bar & Grill", detail2: "Acme", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.AcmeTime, phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: self.AcmeCircle, ratings: AcmeDataPiece) else {
            fatalError("Unable to instantiate location2")
        }
        guard let Pussers = location(detail1: "Pusser's Caribbean Grille", detail2: "Pussers", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.PussersTime, phoneNumber: "3017797044", displayedAddress: "7325 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 779-7044", llLocation: self.PussersCircle, ratings: PussersDataPiece) else {
            fatalError("Unable to instantiate location2")
        }
        guard let FedHouse = location(detail1: "The Federal House", detail2: "Federal House", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.ChipotleTime, phoneNumber: "3012778377", displayedAddress: "4410 Knox Rd, College Park, MD", displayedPhoneNumber: "(301) 277-8377", llLocation: self.ChipotleCircle, ratings: ChipotleDataPiece) else {
            fatalError("Unable to instantiate location2")
        }
        guard let McGarveys = location(detail1: "McGarvey's", detail2: "McGarveys", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.McGraveysTime, phoneNumber: "3012090635", displayedAddress: "7422 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 209-0635", llLocation: self.McGarveysCircle, ratings: McGarveysDataPiece) else {
            fatalError("Unable to instantiate location2")
        }
        
        guard let Dilos = location(detail1: "Armadillos Restaurant", detail2: "Armadillos", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.RedBeanTime, phoneNumber: "3012090635", displayedAddress: "7422 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 209-0635", llLocation: self.RedBeanCirle, ratings: RedBeanDataPiece) else {
            fatalError("Unable to instantiate location2")
        }
        
        guard let DockStreet = location(detail1: "Dock Street Bar & Grill", detail2: "Dock Street", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.DockStreetTime, phoneNumber: "3012090635", displayedAddress: "7422 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 209-0635", llLocation: self.DockStreetCircle
            , ratings: DockStreetDataPiece) else {
                fatalError("Unable to instantiate location2")
        }
        
        locationList = [Acme, Pussers, McGarveys, DockStreet, Dilos, FedHouse]
        
        locations.removeAll()
        
        locations += [Acme, Pussers, McGarveys, DockStreet, Dilos, FedHouse]
        
        locations.sort  { $0.detail1 < $1.detail1 }
        
        tableView.reloadData()
        
    }
    
    */
    /*
    func sampleLocationsCP() {
        
        guard let Bentleys = location(detail1: "RJ Bentley's Restaurant", detail2: "Bentleys", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.BentleysTime, phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: self.BentleysCircle, ratings: AcmeDataPiece) else {
            fatalError("Unable to instantiate location2")
        }
        guard let TerrapinTurf = location(detail1: "Terrapin's Turf", detail2: "Terrapins Turf", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.TerrapinsTurfTime, phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: self.TerrapinsTurfCircle, ratings: AcmeDataPiece) else {
            fatalError("Unable to instantiate location2")
        }
        guard let CornerStone = location(detail1: "Cornerstone Grill & Loft", detail2: "Cornerstone", special: AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.CornerstoneTime, phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: self.CornerstoneCircle, ratings: AcmeDataPiece) else {
            fatalError("Unable to instantiate location2")
        }
   
        locationList = [Bentleys, TerrapinTurf, CornerStone]
        
        locations.removeAll()
        
        locations += [Bentleys, TerrapinTurf, CornerStone]
        
        locations.sort  { $0.detail1 < $1.detail1 }
        
        tableView.reloadData()
        
    }
 */

    func endLoading() {
        
        self.ActivityIndicator.stopAnimating()
        
        self.ActivityIndicator.hidesWhenStopped = true
        
        self.ActivityView.isHidden = true
    }
    
    @objc private func progressloading() {
        //  loadData1()
    }
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
       // NewLoadData()
        
        locations.removeAll()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        
      //    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       // self.navigationController?.navigationBar.
       
        //   UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
      //  self.navigationController?.view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1647058824, blue: 0.8470588235, alpha: 1)
       // UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
       // self.navigationController?.view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1647058824, blue: 0.8470588235, alpha: 1)

          DispatchQueue.main.async() {  self.NewDataLoad2() }
             DispatchQueue.main.async() { self.tableView.reloadData() }
        
    }
    
    private func loadAfterunwind() {
        //loadData1()
        NewDataLoad2()
    }
    
    private func saveRatings() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(locations, toFile: location.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Locations successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save locations...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadRatings()-> [location]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: location.ArchiveURL.path) as? [location]
    }
    
    private func RefresherRequestForData() {
        
        self.ActivityIndicator.stopAnimating()
        
        self.ActivityIndicator.hidesWhenStopped = true
        
        self.ActivityView.isHidden = true
        
       // NewLoadData()
        locations.removeAll()
        NewDataLoad2()
        
        timer =  Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(endOfWork), userInfo: nil, repeats: false)
        
        print("time set")
    }
    
    func endOfWork() {
        refreshControl!.endRefreshing()
        
        timer.invalidate()
        timer = nil
        print("end of work")
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl!.isRefreshing {
            
            RefresherRequestForData()
        
            print("refresherRequest")
        }
    }
    
    private func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        if seconds < 0 {
            return String("1m")
        }
        if seconds < 60 && minutes == 0 && hours == 0 {
            return String("1m")
        }
        if seconds > 60 || hours == 0{
            return String(format: "%2d", minutes) + "m"
        }
        if minutes > 60  || hours == 1{
            return String(format: "%2d", hours) + "h"
        }
        if minutes > 60  || hours > 1{
            return String(format: "%2d", hours) + "h"
        } else {
            print("else")
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
    
    
   
    private func LocationSelected() {
        
    }
}
