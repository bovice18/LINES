//
//  LocationDetailViewController.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import os.log

//import UberRides

class LocationDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate,  MKMapViewDelegate {
    
    @IBOutlet weak var barBackground: UIImageView!
    var Specials = [Special]()
    var fullSpecialsString = String()
    
    var locationPostName = String()
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        var lineRating = Int()
        switch LineImage.image! {
        case UIImage(named: "0-5")!:
          lineRating = 1
        case UIImage(named: "5-10")!:
            lineRating = 2
        case UIImage(named: "10-20")!:
            lineRating = 3
        case UIImage(named: "20+")!:
            lineRating = 4
        default:
            print("no circle rating found")
        }
        
         var request = URLRequest(url: URL(string: "http://waitmatehq.com/insertTest.php")!)
         
         request.httpMethod = "POST"
         
         let postString = "Location_Name=\(locationPostName)"+"&Circle_Rating=\(lineRating)"
         
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
         
       //  self.performSegue(withIdentifier: "Confirmed", sender: sender)
    
    }
    
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    //Swipe left action to move to specials page
 //   @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer) {
  //      performSegue(withIdentifier: "Switch", sender: sender)
  //  }
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var timeSincePostLbl: UILabel!
    
    @IBOutlet weak var LineImage: UIImageView!
    
    @IBOutlet weak var graphTitleLbl: UILabel!
    
    @IBOutlet weak var GraphDisplayView: UIView!
    
    @IBOutlet weak var FirstWhiteView: UIView!
    
    @IBOutlet weak var WaitSegmentedControl: UISegmentedControl!
  //  @IBAction func switchButtonPressed(_ sender: UISegmentedControl) {
        
       /* switch sender.selectedSegmentIndex {
        case 0:
            print("Wait")
        case 1:
            print("Specials")
            performSegue(withIdentifier: "Switch", sender: sender)
        default:
            print("failed segment")
        }
 
 */
    //}

    //Button to post
    @IBOutlet weak var joinTheLineButton: UIBarButtonItem!
    //old table view, no longer exists need to delete
   
    //old label for address,, check to see if still used
    @IBOutlet weak var adressLbl: UILabel!
    //old label for phone number,, check to see if still used
    @IBOutlet weak var phoneLbl: UILabel!
    //save button == back **check to make sure
    @IBOutlet weak var saveButton: UIBarButtonItem!

    //Estimated Wait Bar Graphs
    @IBOutlet weak var barDisplay1: UIView!  //bar display at 1 am
    @IBOutlet weak var barDisplay2: UIView!  //bar display at 12pm
    @IBOutlet weak var barDisplay3: UIView!  //bar display at 11pm
    @IBOutlet weak var barDisplay4: UIView!  //bar display at 10pm
    @IBOutlet weak var barDisplay5: UIView!  //bar display at 9pm
    @IBOutlet weak var barDisplay6: UIView!  //bar display at 8pm
    @IBOutlet weak var barDisplay7: UIView!  //bar display at 7pm
    @IBOutlet weak var barDisplay8: UIView!  //bar display at 6pm
    @IBOutlet weak var barDisplay9: UIView!  //bar display at 5pm
    @IBOutlet weak var barDisplay10: UIView!  //bar display at 4pm
     //bar display not used for a time
    @IBOutlet weak var barDisplay11: UIView!
     //bar display not used for time
    @IBOutlet weak var barDisplay12: UIView!
    
    var MondayDeal: Special?
    var AllDeals = [Special]()
    var imageNumber: Int?
    
    var timeLblData: String?
    
    var Location: location?
    
    var ratings = [rating]()
    
  //  var specials = [Special]()
    
    //Variables for different estimated waits
    var waitsAt11 = Int()
    var waitsAt12 = Int()
    var waitsAt1 = Int()
    var waitsAt2 = Int()
    var waitsAt3 = Int()
    var waitsAt4 = Int()
    var waitsAt5 = Int()
    var waitsAt6 = Int()
    var waitsAt7 = Int()
    var waitsAt8 = Int()
    var waitsAt9 = Int()
    var waitsAt10 = Int()
    
    //do not know what is used for
  /* var ratingsAt11 = [rating]()
    var ratingsAt12 = [rating]()
    var ratingsAt1 = [rating]()
    var ratingsAt2 = [rating]()
    var ratingsAt3 = [rating]()
    var ratingsAt4 = [rating]()
    var ratingsAt5 = [rating]()
    var ratingsAt6 = [rating]()
    var ratingsAt7 = [rating]()
   */
    
    var BarDisplayData = [Int]()
    
    //var BarDisplays = [BarDisplayDataPiece]()
    
    let locationManager = CLLocationManager()
    
    var directPost: Int?
    
  //  let FridayDeal = Special(name: "FRIDAY", details: "Mixed Drinks", Image: #imageLiteral(resourceName: "acme2"))
    
    @IBOutlet weak var coloredView: UIView!
    
    var refreshControl: UIRefreshControl!
    
    var timer: Timer!
  /*
    func NewLoadData() {
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
            
            var locationName = String()
            
            switch self.navigationItem.title! {
                
            case "Acme Bar & Grill":
                locationName = "Acme"
                
            case "Armadillos Restaurant":
                locationName = "Armadillos"
                
            case "Dock Street Bar & Grill":
                locationName = "Dock Street"
                
            case "McGarvey's":
                locationName = "McGarveys"
                
            case "Pusser's Caribbean Grille":
                locationName = "Pussers"
                
            case "The Federal House":
                locationName = "Federal House"
                
            case "RJ Bentley's Restaurant":
                locationName = "Bentleys"
                
            case "Cornerstone Grill & Loft":
                locationName = "Cornerstone"
                
            case "Terrapin's Turf":
                locationName = "Terrapins Turf"
                
                
            default:
                print("unknown Name")
            }
            print(locationName)
            print("locationName")
            
            if let dictionary = json as? [String: Any] {
                
                if let nestedDictionary = dictionary[locationName] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
                    if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        print(recent)
                        
                        self.imageNumber = Int(recent)!
                        
                        self.updateCircleRating()
                        
                        //  self.AcmeCircle = Int(recent)!
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
                            
                            self.timeLblData = TimeSincePost
                        } else {
                            self.timeLblData = "no recent posts"
                        }
                    }
                    
                    let hourArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14","15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
                    
                    
                    
                    if let nestedDictionary1 = nestedDictionary["estimated"] as? [String: Any] {
                        print("inside")
                        print(nestedDictionary1)
                        
                        for number in hourArray {
                            print(number)
                            
                            if let lastupdated = nestedDictionary1[number] as? String {
                                
                                switch number {
                                case "2":
                                    print("average at 1")
                                    print(lastupdated)
                                    self.waitsAt1 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay2() }
                                case "14":
                                    print("average at 2")
                                    print(lastupdated)
                                    self.waitsAt2 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay2() }
                                case "15":
                                    print("average at 3")
                                    print(lastupdated)
                                    self.waitsAt3 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay3() }
                                case "16":
                                    print("average at 4")
                                    print(lastupdated)
                                    self.waitsAt4 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay4() }
                                case "17":
                                    print("average at 5")
                                    print(lastupdated)
                                    self.waitsAt5 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay5() }
                                case "18":
                                    print("average at 6")
                                    print(lastupdated)
                                    self.waitsAt6 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay10() }
                                case "19":
                                    print("average at 7")
                                    print(lastupdated)
                                    self.waitsAt7 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay6() }
                                case "20":
                                    print("average at 8")
                                    print(lastupdated)
                                    self.waitsAt8 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay7() }
                                case "21":
                                    print("average at 9")
                                    print(lastupdated)
                                    self.waitsAt9 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay8() }
                                case "22":
                                    print("average at 10")
                                    print(lastupdated)
                                    self.waitsAt10 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay9() }
                                case "23":
                                    print("average at 11")
                                    print(lastupdated)
                                    self.waitsAt11 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay() }
                                case "0":
                                    print("average at 12")
                                    print(lastupdated)
                                    self.waitsAt12 = Int(lastupdated)!
                                    DispatchQueue.main.async() {
                                        self.loadBarDisplay1()}
                                default:
                                    print("not a real time")
                                }
                                
                            }
                            //   self.loadBarDisplay()
                        }
                    }
                    
                    
                    if let nestedDictionary1 = nestedDictionary["estimated"] as? [String: Any] {
                        print("inside")
                        print(nestedDictionary1)
                        
                        if let lastupdated = nestedDictionary1["0"] as? String {
                            print("0")
                            print(lastupdated)
                        }
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    
                    // Get value by key
                    let firstNameValue = convertedJsonIntoDict["locationName"] as? String
                    //   print(firstNameValue!)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
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
                //INITIAL ACCESS POINT FOR DATA
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
                    //NOW ENTERING THE OBJECTS THAT MAKE UP THE ARRAY "{'':""}"
                    guard let dictionary = object as? [String: Any] else {
                        print("error")
                        return
                    }
                        print("inside here")
                        print(dictionary)
                    
                    //*EXAMPLE*METHOD FOR GETTING THE ESTIMATED WAIT AT 17
                    /*
                        guard let nestedDictionary = dictionary["estimated"] as? [String: Any] else {
                            print("error")
                            return
                        }
                            print(nestedDictionary)
                            print("nested here")
                    
                            guard let number = nestedDictionary["17"] as? String else {
                                print("error")
                                return
                            }
                            // access individual value in dictionary
                            print(number)
                    */
                
                    guard let name = dictionary["locationName"] as? String, //Location name accessed
                        let recent = dictionary["recent"] as? String, //recent post accessed as string
                        let lastUpdated = dictionary["lastUpdated"] as? String, //recent post time accessed as string
                         let longName = dictionary["longName"] as? String //recent post time accessed as string
                        else {
                            print("error")
                            return
                    }
                   //if the location out of the lists of locations is equal to the navigation controller then
              if longName == self.navigationItem.title {
                
                //making the recent post into an integer
                    let numberRecent = Int(recent)
                //setting the image number as the recent post and the reloading it on the main thread
                    self.imageNumber = numberRecent
                
                    DispatchQueue.main.async() { self.updateCircleRating() }
                        print(numberRecent)
                        print("recent number")
                
                    }
                    
                   // guard let Acme = location(detail1: name, detail2: name, special: self.AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: lastUpdated, phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: numberRecent!, ratings: self.AcmeDataPiece) else {
                    //    fatalError("Unable to instantiate location2")
                   // }
                  //  self.locations.append(Acme)
                   // self.tableView.reloadData()
                }
                //ACCESSSING ALL ESTIMATED WAIT DATA
                for object in array {
                    
                    guard let dictionary = object as? [String: Any] else {
                        print("error")
                        return
                    }
                    print("inside here")
                    print(dictionary)
                    
                    guard let longName = dictionary["longName"] as? String else {
                        print("error")
                        return
                    }
                    
                    print("inside here")
                    print(longName)
                    
                    if longName == self.navigationItem.title {
                        
                    
                    guard let nestedDictionary = dictionary["estimated"] as? [String: Any] else {
                        print("error")
                        return
                    }
                    
                    print(nestedDictionary)
                    print("nested here")
                    
                    let hourArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14","15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
                    
                   // let average1 = Int()
                    
                   // let hourArray2 = [String: Int]()

            
                    for hour in hourArray {
                        
                       if let lastupdated = nestedDictionary[hour] as? String {
                        
                       /* guard let number = nestedDictionary[hour] as? String else {
                            print("error")
                            return
                        }
                        */
                        print(lastupdated)
                        print(hour)
                        
                        switch hour {
                        case "2":
                            print("average at 1")
                            print(lastupdated)
                            self.waitsAt1 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay2() }
                        case "14":
                            print("average at 2")
                            print(lastupdated)
                            self.waitsAt2 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay2() }
                        case "15":
                            print("average at 3")
                            print(lastupdated)
                            self.waitsAt3 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay3() }
                        case "16":
                            print("average at 4")
                            print(lastupdated)
                            self.waitsAt4 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay4() }

                        case "17":
                            print("average at 5")
                            print(lastupdated)
                            self.waitsAt5 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay5() }
                        case "18":
                            print("average at 6")
                            print(lastupdated)
                            self.waitsAt6 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay10() }
                        case "19":
                            print("average at 7")
                            print(lastupdated)
                            self.waitsAt7 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay6() }
                        case "20":
                            print("average at 8")
                            print(lastupdated)
                            self.waitsAt8 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay7() }
                        case "21":
                            print("average at 9")
                            print(lastupdated)
                            self.waitsAt9 = Int(lastupdated)!
                            DispatchQueue.main.async() { self.loadBarDisplay8() }
                        case "22":
                            print("average at 10")
                            print(lastupdated)
                            self.waitsAt10 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay9() }
                        case "23":
                            print("average at 11")
                            print(lastupdated)
                            self.waitsAt11 = Int(lastupdated)!
                            DispatchQueue.main.async() {
                                self.loadBarDisplay() }
                        case "0":
                            print("average at 12")
                            print(lastupdated)
                            self.waitsAt12 = Int(lastupdated)!
                            DispatchQueue.main.async() {  self.loadBarDisplay1() }
                        default:
                            print("not a real time")
                        }
              DispatchQueue.main.async() { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
                    }
                        }
                    }
              
                    // access individual value in dictionary
                   // print(number)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    //  UINavigationBar.appearance().backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        mapView.delegate = self
        
        mapView.layer.cornerRadius = 4
        mapView.layer.cornerRadius = 4
        
        
        
        confirmButton.layer.cornerRadius = 4
        postButton.layer.cornerRadius = 4
        postButton.layer.borderWidth = 1
        postButton.layer.borderColor = #colorLiteral(red: 0.3430494666, green: 0.8636034131, blue: 0.467017293, alpha: 1)
        
        //tableView.layer.borderWidth = 1
       // tableView.layer.borderColor
        tableView.layer.cornerRadius = 4
        
    
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        //    self.locationManager.requestAlwaysAuthorization()
        // self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    
        LoadingAllSpecials()
        //   animateBars()
        
      //  AllDeals.append(FridayDeal!)
        
       // NewLoadData()
       DispatchQueue.main.async() { self.NewDataLoad2() }
        
        //New TABLE VIEW LOADING
        tableView.delegate = self
        tableView.dataSource = self
    
        
        //ADDING BLUR EFFECT
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubview(toBack: blurEffectView)
        
        //ROUNDING EDGES
        GraphDisplayView.layer.cornerRadius = 4
        FirstWhiteView.layer.cornerRadius = 4
       // tableView.layer.cornerRadius = 4
        graphTitleLbl.layer.cornerRadius = 5
        
        if let location = Location {
            
            Location?.locationName = location.locationName
            
            Location?.longitude = location.longitude
            Location?.latitude = location.latitude
            
           //way to load recent without connection
            /*let recent = location.recent
            //making the recent post into an integer
            let numberRecent = Int(recent)
            //setting the image number as the recent post and the reloading it on the main thread
            self.imageNumber = numberRecent
            */
            
           // AllDeals = location.special //OLD WAY FOR LOADING SPECIAL
            
        //    print(location.ratings)
          //  print(BarDisplays.count)
          //  print(location.ratings.count)
         // BarDisplays = location.ratings
          //  print(BarDisplays.first?.postTime as Any)
         //   print(BarDisplays.first?.waitTime as Any)
            
            print("target")
            
            navigationItem.title = location.locationNameLong
            
            locationPostName = location.locationName
            

            print("entered")
        }
        
         //waitmatehq.com/img/Annapolis,_MD.jpg
        let locationName = locationPostName.replacingOccurrences(of: " ", with: "_")
        let url = NSURL(string: "http://waitmatehq.com/img/\(locationName).jpg")
        let data = NSData(contentsOf:  (url as? URL)!)
        if data != nil
        {
            let image = UIImage(data: data as! Data)
            barBackground.image = image
        }
        else {
            let currentLocation = UserDefaults.standard.value(forKey: "CurrentLocation") as! String
            let locationName = currentLocation.replacingOccurrences(of: " ", with: "_")
            let url = NSURL(string: "http://waitmatehq.com/img/\(locationName).jpg")
            let data = NSData(contentsOf:  (url as? URL)!)
            let image = UIImage(data: data as! Data)
            barBackground.image = image
        }
        
        // NewDataLoad2()
        //   SortingBarDisplayData()
        
        let locationTableView = LocationTableViewController()
        
        let locationDetailView = LocationDetailViewController()
        
        let jointheline = UIStoryboardSegue.init(identifier: "JoinTheLine", source: locationTableView, destination: locationDetailView)
        
        jointheline.destination.navigationItem.title = "name"
        
        //old code used to switch the navigation title and keep track of location
     /*   let title = (Location?.detail1)!
        switch title {
        case "Dock Street Bar & Grill":
            UserDefaults.standard.set(1, forKey: "title")
            UserDefaults.standard.synchronize()
        case "Acme Bar & Grill":
            UserDefaults.standard.set(2, forKey: "title")
            UserDefaults.standard.synchronize()
        case "Pusser's Caribbean Grille":
            UserDefaults.standard.set(3, forKey: "title")
            UserDefaults.standard.synchronize()
        case "Armadillos Restaurant":
            UserDefaults.standard.set(4, forKey: "title")
            UserDefaults.standard.synchronize()
        case "McGarvey's":
            UserDefaults.standard.set(5, forKey: "title")
            UserDefaults.standard.synchronize()
        case "The Federal House":
            UserDefaults.standard.set(6, forKey: "title")
            UserDefaults.standard.synchronize()
        case "RJ Bentley's Restaurant":
            UserDefaults.standard.set(7, forKey: "title")
            UserDefaults.standard.synchronize()
        case "Cornerstone Grill & Loft":
            UserDefaults.standard.set(8, forKey: "title")
            UserDefaults.standard.synchronize()
        case "Terrapin's Turf":
            UserDefaults.standard.set(9, forKey: "title")
            UserDefaults.standard.synchronize()
        default:
            UserDefaults.standard.set(0, forKey: "title")
            UserDefaults.standard.synchronize()
        }
        */
        
        if directPost == 1 {
            
            performSegue(withIdentifier: "Post", sender: viewDidAppear(true))
            
        }
        //    SortingBarDisplayData()
        //    loadBarDisplay()
       
        //rounding the edges of the estimated wait bar graphs
        barDisplay1.layer.cornerRadius = 4
        barDisplay2.layer.cornerRadius = 4
        barDisplay3.layer.cornerRadius = 4
        barDisplay4.layer.cornerRadius = 4
        barDisplay5.layer.cornerRadius = 4
        barDisplay6.layer.cornerRadius = 4
        barDisplay7.layer.cornerRadius = 4
        barDisplay8.layer.cornerRadius = 4
        barDisplay9.layer.cornerRadius = 4
        barDisplay10.layer.cornerRadius = 4
        
        mostRecentTime()
        
        updateCircleRating()
        
        //  loadBarDisplay()
        
        refreshControl = UIRefreshControl()
        
       // tableView.addSubview(refreshControl!)
        
        /*      switch imageNumber {
         case 1?:
         LineImage.image = UIImage(named: "0-5")
         case 2?:
         LineImage.image = UIImage(named: "5-10")
         case 3?:
         LineImage.image = UIImage(named: "10-20")
         case 4?:
         LineImage.image = UIImage(named: "20+")
         default:
         print("no circle rating found")
         }
         */
    
        mapDetails()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //tableView.reloadData()
        mostRecentTime()
        
        // updateCircleRating()
        
        // ClearingTable()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source ----- ALL OLD TABLEVIEW IS PHASED OUT BEFORE VERISON 1.0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Specials.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view ells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "SpecialCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SpecialsTableViewCell
        
        // Fetches the appropriate day for the data source laout
        let special = Specials[indexPath.row]
        
        cell.titleLbl.text = special.name
        
        cell.specialDetailLbl.text = special.details
    

        return cell
    }
    
    
    // MARK: - Navigation
    @IBAction func unwindToRatingList(sender: UIStoryboardSegue) {
        
        WaitSegmentedControl.selectedSegmentIndex = 0
        
        if let sourceViewController = sender.source as? RatingViewController, let rating = sourceViewController.Rating {
            
            //Reloads table data so it is ordered from most recent at the top
            tableView.reloadData()
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "Hh:mm"
            
            dateFormatter.dateFormat = "HH"
            
            let dateString = dateFormatter.string(from: rating.timeIntervalSinceNow! as Date)
            
            print(dateString)
            
            UserDefaults.standard.set(true, forKey: "switchState")
            
            UserDefaults.standard.synchronize()
            
            Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(LocationDetailViewController.resetPost), userInfo: nil, repeats: false)
            
            print("timer started")
            
            saveRatings()
        }
        
        mostRecentTime()
        
        updateCircleRating()
        
        saveRatings()
    }
    
    func resetPost() {
        
        UserDefaults.standard.set(false, forKey: "switchState")
        
        UserDefaults.standard.synchronize()
        
        print("timer stopped")
    }
    
    /*func changeTitleBack() {
        
        navigationItem.title = Location?.detail1
    }
    */
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // This method lets you configure a view controller before it's presented.
        super.prepare(for: segue, sender: sender)
        
        print("locationnameis")
        print(Location?.locationNameLong)
        
        let segueNames = ["Post", "Post1"]
        
        for name in segueNames {
            
            print("locationnameis3")
            print(Location?.locationNameLong)
            
            //let name2 = Location?.detail1
            switch(segue.identifier ?? "") {
                
            case name:
                print("segue")
                
              //  guard let PostViewController = segue.destination as? RatingViewController else {
               //     fatalError("Unexpected destination: \(segue.destination)")
              //  }
                print(Location)
              //  let PostViewController = RatingViewController()
             //   PostViewController.Location?.detail1 = (Location?.detail1)!
              //  PostViewController.Location = Location
                
                print("locationnameis2")
                print(Location?.locationNameLong)
                
            default:
                print("error")
            }
        }

        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let locationName = Location?.locationName
        
        let locationNameLong = Location?.locationNameLong
        
        let specials = Location?.special
        
        let cityId = Location?.cityId
        
        let cityName = Location?.cityName
        
        let latitude = Location?.latitude
        
        let longitude = Location?.longitude
        
        let locationId = Location?.locationId
        
        let recent = Location?.recent
        
        let recentTime = Location?.recentTime
        
        // Set the reting to be passed to LocationTableViewController after the unwind segue.
        Location = location(locationName: locationName!, locationNameLong: locationNameLong!, special: specials!, cityId: cityId!, cityName: cityName!, latitude: latitude!, longitude: longitude!, locationId: locationId!, recent: recent!, recentTime: recentTime!)
 
        
        //  loadData()
        
      //  NewLoadData()
        
        saveRatings()
        
        mostRecentTime()
        
        updateCircleRating()
        
       // print(ratingList)
        
        print("sent info back to start")
      
    }
    
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    private func saveRatings() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ratings, toFile: rating.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Rating successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save ratings...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadRatings()-> [rating]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: rating.ArchiveURL.path) as? [rating]
    }
    
    //MARK: Actions
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
    
    private func stringSecondaryFromTimeInterval(interval: TimeInterval) -> Int {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        if seconds < 0 {
            return Int(-hours)
        }
        if seconds < 60 && minutes == 0 && hours == 0 {
            return Int(-hours)
        }
        if seconds > 60 || hours == 0{
            return Int(-hours)
        }
        if minutes > 60  || hours == 1{
            return Int(-hours)
        }
        if minutes > 60  || hours > 1{
            return Int(-hours)
        } else {
            print("else")
            return Int(-hours)
        }
    }
    
    private func updateCircleRating() {
        
        //all used when there was a table view
      /* // if ratings.count >= 1 {
          //  let indexPath1 = NSIndexPath(row: 0, section: 0)
          //  let cellIdentifier = "RatingTableViewCell"
           // let mostRecentRating = ratings[indexPath1.row]
            switch mostRecentRating.circleRating {
            case 1:
                LineImage.image = UIImage(named: "0-5")
            case 2:
                LineImage.image = UIImage(named: "5-10")
            case 3:
                LineImage.image = UIImage(named: "10-20")
            case 4:
                LineImage.image = UIImage(named: "20+")
            default:
                print("no circle rating found")
            }
        }
       // else {
            */
            switch imageNumber {
            case 0?:
                LineImage.image = UIImage(named: "0-5")
                
            case 1?:
                LineImage.image = UIImage(named: "0-5")
            case 2?:
                LineImage.image = UIImage(named: "5-10")
            case 3?:
                LineImage.image = UIImage(named: "10-20")
            case 4?:
                LineImage.image = UIImage(named: "20+")
            default:
                print("no circle rating found")
        }
        timeSincePostLbl.text = ""
    }
    
    func mostRecentTime() {
        
        //Old code used when table view existed
      /*  if ratings.count >= 1{
            
            let indexPath1 = NSIndexPath(row: 0, section: 0)
            
            let cellIdentifier = "RatingTableViewCell"
            
            let mostRecentRating = ratings[indexPath1.row]
            
            let PostedDate = mostRecentRating.timeIntervalSinceNow
            
            let intervalSincePost = PostedDate?.timeIntervalSinceNow
            
            let postedDate = stringFromTimeInterval(interval: intervalSincePost! * -1)
            
            timeSincePostLbl.text = postedDate
        }
        else {
 */
        
          //  timeSincePostLbl.text = timeLblData

    }
    
    private func RefresherRequestForData1() {
        
        timer =  Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(endOfWork), userInfo: nil, repeats: false)
        
        print("time set")
    }
    
    func endOfWork() {
        
        refreshControl!.endRefreshing()
        
        timer.invalidate()
        timer = nil
        print("end of work")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if refreshControl!.isRefreshing {
            RefresherRequestForData1()
            print("refresherRequest")
        }
    }
    
 /*   func loadData() {
        
        let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
        
        // Add one parameter
        let urlWithParams = scriptURL
        
        let myUrl = NSURL(string: urlWithParams);
        
        let request = NSMutableURLRequest(url: myUrl! as URL);
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
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
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            if let dictionary = json as? [String: Any] {
                if let number = dictionary["ratingId"] as? String {
                    // access individual value in dictionary
                    print(number)
                }
                
                if let nestedDictionary = dictionary[""] as? [String: Any] {
                    print(nestedDictionary)
                    print("anything")
                    // access nested dictionary values by key
                }
            }
            
            if let array = json as? [Any] {
                if let firstObject = array.first {
                    print("firstObject")
                    print(firstObject)
                    
                    if let dictionary = firstObject as? [String: Any] {
                        
                        var time1 = NSDate()
                        
                        var locationName1: String
                        
                        var circleRating1: Int
                        
                        if let ratingId = dictionary["ratingId"] as? String {
                            
                            // access individual value in dictionary
                            print(ratingId)
                            
                            if let circleRating = dictionary["circleRating"] as? String {
                                
                                // access individual value in dictionary
                                print(circleRating)
                                
                                circleRating1 = Int(circleRating)!
                                
                                if let locationName = dictionary["locationName"] as? String {
                                    
                                    // access individual value in dictionary
                                    print(locationName)
                                    
                                    locationName1 = locationName
                                    
                                    if let timeDate = dictionary["timeDate"] as? NSDate {
                                        // access individual value in dictionary
                                        print(timeDate)
                                        
                                        time1 = timeDate
                                        
                                    }
                                    
                                    if locationName1 == "Acme" {
                                        
                                        print(self.ratings)
                                        
                                        print("working")
                                    }
                                }
                            }
                        }
                    }
                }
                
                if let firstObject = array.last {
                    print("firstObject")
                    print(firstObject)
                    
                    if let dictionary = firstObject as? [String: Any] {
                        
                        if let ratingId = dictionary["ratingId"] as? String {
                            // access individual value in dictionary
                            print(ratingId)
                            
                        }
                        
                        if let locationName = dictionary["locationName"] as? String {
                            // access individual value in dictionary
                            print(locationName)
                            
                        }
                        if let timeDate = dictionary["timeDate"] as? String {
                            // access individual value in dictionary
                            print(timeDate)
                            
                        }
                    }
                }
                
                for object in array {
                    
                    if let dictionary = object as? [String: Any] {
                        
                        var time1: Date
                        
                        var locationName1: String
                        
                        var circleRating1: Int
                        
                        
                        if let circleRating = dictionary["circleRating"] as? String {
                            
                            // access individual value in dictionary
                            print(circleRating)
                            
                            circleRating1 = Int(circleRating)!
                            
                            if let locationName = dictionary["locationName"] as? String {
                                
                                // access individual value in dictionary
                                print(locationName)
                                
                                locationName1 = locationName
                                
                                if let timeDate = dictionary["timeDate"] as? String {
                                    
                                    // access individual value in dictionary
                                    print(timeDate)
                                    
                                    let dateFormatter = DateFormatter()
                                    
                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    
                                    let date1 = dateFormatter.date(from: timeDate)!
                                    
                                    time1 = date1
                                    
                                    let rating1 = rating(locationName: locationName1, time: timeDate, circleRating: circleRating1, timeIntervalSinceNow: time1 as NSDate?)
                                    
                                    let Filter = self.navigationItem.title!
                                    
                                    switch Filter {
                                        
                                    case "Acme Bar & Grill":
                                        
                                        if locationName1 == "Acme" {
                                            
                                            self.imageNumber = rating1?.circleRating
                                            
                                            self.updateCircleRating()
                                            
                                            let time = rating1?.timeIntervalSinceNow
                                            
                                            let timeInterval = time?.timeIntervalSinceNow
                                            
                                            let stringTime = self.stringSecondaryFromTimeInterval(interval: timeInterval!)
                                            
                                            print(stringTime)
                                            
                                            print("stringtime")
                                            
                                            if stringTime <= 2 {
                                                self.ratings.append(rating1!)
                                                
                                                print("inside constraint")
                                            }
                                            
                                            let PostedDate = rating1?.timeIntervalSinceNow
                                            
                                            let intervalSincePost = PostedDate?.timeIntervalSinceNow
                                            
                                            let postedDate = self.stringFromTimeInterval(interval: intervalSincePost! * -1)
                                            
                                            self.timeLblData = postedDate
                                            
                                            self.mostRecentTime()
                                            
                                            //self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    case "Armadillos Restaurant":
                                        
                                        if locationName1 == "Armadillos" {
                                            
                                            self.imageNumber = rating1?.circleRating
                                            
                                            self.updateCircleRating()
                                            
                                            let time = rating1?.timeIntervalSinceNow
                                            
                                            let timeInterval = time?.timeIntervalSinceNow
                                            
                                            let stringTime = self.stringSecondaryFromTimeInterval(interval: timeInterval!)
                                            
                                            print(stringTime)
                                            
                                            print("stringtime")
                                            
                                            if stringTime <= 2 {
                                                self.ratings.append(rating1!)
                                                
                                                print("inside constraint")
                                            }
                                            
                                            let PostedDate = rating1?.timeIntervalSinceNow
                                            
                                            let intervalSincePost = PostedDate?.timeIntervalSinceNow
                                            
                                            let postedDate = self.stringFromTimeInterval(interval: intervalSincePost! * -1)
                                            
                                            self.timeLblData = postedDate
                                            
                                            self.mostRecentTime()
                                            
                                            //self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    case "Pusser's Caribbean Grille":
                                        
                                        if locationName1 == "Pussers" {
                                            
                                            self.imageNumber = rating1?.circleRating
                                            
                                            self.updateCircleRating()
                                            
                                            let time = rating1?.timeIntervalSinceNow
                                            
                                            let timeInterval = time?.timeIntervalSinceNow
                                            
                                            let stringTime = self.stringSecondaryFromTimeInterval(interval: timeInterval!)
                                            
                                            print(stringTime)
                                            
                                            print("stringtime")
                                            
                                            if stringTime <= 2 {
                                                self.ratings.append(rating1!)
                                                
                                                print("inside constraint")
                                            }
                                            
                                            let PostedDate = rating1?.timeIntervalSinceNow
                                            
                                            let intervalSincePost = PostedDate?.timeIntervalSinceNow
                                            
                                            let postedDate = self.stringFromTimeInterval(interval: intervalSincePost! * -1)
                                            
                                            self.timeLblData = postedDate
                                            
                                            self.mostRecentTime()
                                            
                                            //self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                    case "Moe's Southwest Grill":
                                        
                                        if locationName1 == "Moes" {
                                            
                                            let time = rating1?.timeIntervalSinceNow
                                            
                                            let timeInterval = time?.timeIntervalSinceNow
                                            
                                            let stringTime = self.stringSecondaryFromTimeInterval(interval: timeInterval!)
                                            
                                            print(stringTime)
                                            
                                            print("stringtime")
                                            
                                            if stringTime <= 2 {
                                                self.ratings.append(rating1!)
                                                
                                                print("inside constraint")
                                            }
                                            
                                            //self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    case "McGarvey's":
                                        
                                        if locationName1 == "McGarveys" {
                                            
                                            self.imageNumber = rating1?.circleRating
                                            
                                            self.updateCircleRating()
                                            
                                            let time = rating1?.timeIntervalSinceNow
                                            
                                            let timeInterval = time?.timeIntervalSinceNow
                                            
                                            let stringTime = self.stringSecondaryFromTimeInterval(interval: timeInterval!)
                                            
                                            print(stringTime)
                                            
                                            print("stringtime")
                                            
                                            if stringTime <= 2 {
                                                self.ratings.append(rating1!)
                                                
                                                print("inside constraint")
                                            }
                                            
                                            //self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    case "The Federal House":
                                        
                                        if locationName1 == "Federal House" {
                                            
                                            self.imageNumber = rating1?.circleRating
                                            
                                            self.updateCircleRating()
                                            
                                            let time = rating1?.timeIntervalSinceNow
                                            
                                            let timeInterval = time?.timeIntervalSinceNow
                                            
                                            let stringTime = self.stringSecondaryFromTimeInterval(interval: timeInterval!)
                                            
                                            print(stringTime)
                                            
                                            print("stringtime")
                                            
                                            if stringTime <= 2 {
                                                self.ratings.append(rating1!)
                                                
                                                print("inside constraint")
                                            }
                                            
                                            let PostedDate = rating1?.timeIntervalSinceNow
                                            
                                            let intervalSincePost = PostedDate?.timeIntervalSinceNow
                                            
                                            let postedDate = self.stringFromTimeInterval(interval: intervalSincePost! * -1)
                                            
                                            self.timeLblData = postedDate
                                            
                                            self.mostRecentTime()
                                            
                                            //self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    case "Annapolis Ice Cream Co":
                                        
                                        if locationName1 == "Annapolis Ice Cream Co" {
                                            
                                            self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                            
                                        }
                                        
                                    case "Joss Cafe & Sushi Bar":
                                        
                                        if locationName1 == "Joss" {
                                            
                                            self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    case "City Dock Cafe":
                                        
                                        if locationName1 == "City Dock Cafe" {
                                            
                                            self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                            
                                        }
                                    case "Iron Rooster":
                                        
                                        if locationName1 == "Iron Rooset" {
                                            
                                            self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    case "Dock Street Bar & Grill":
                                        
                                        if locationName1 == "Dock Street" {
                                            
                                            self.imageNumber = rating1?.circleRating
                                            
                                            self.updateCircleRating()
                                            
                                            let time = rating1?.timeIntervalSinceNow
                                            
                                            let timeInterval = time?.timeIntervalSinceNow
                                            
                                            let stringTime = self.stringSecondaryFromTimeInterval(interval: timeInterval!)
                                            
                                            let PostedDate = rating1?.timeIntervalSinceNow
                                            
                                            let intervalSincePost = PostedDate?.timeIntervalSinceNow
                                            
                                            let postedDate = self.stringFromTimeInterval(interval: intervalSincePost! * -1)
                                            
                                            self.timeLblData = postedDate
                                            
                                            self.mostRecentTime()
                                            
                                            print(stringTime)
                                            
                                            print("stringtime")
                                            
                                            if stringTime <= 2 {
                                                self.ratings.append(rating1!)
                                                
                                                print("inside constraint")
                                            }
                                            
                                            //self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    case "Storm Bros.":
                                        
                                        if locationName1 == "Storm Bros" {
                                            
                                            self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                            
                                        }
                                        
                                    case "Starbucks":
                                        
                                        if locationName1 == "Starbucks" {
                                            
                                            self.ratings.append(rating1!)
                                            
                                            self.ratings.reverse()
                                            
                                            self.tableView.reloadData()
                                        }
                                        
                                    default:
                                        
                                        self.ratings.reverse()
                                        
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                    
                    print("object")
                    print(object)
                    // access all objects in array
                }
                
                for case let string as String in array {
                    print("string")
                    print(string)
                    // access only string values in array
                }
            }
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    
                    // Get value by key
                    let firstNameValue = convertedJsonIntoDict["ratingId"] as? String
                    print(firstNameValue!)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        tableView.reloadData()
        
        mostRecentTime()
        
        print(BarDisplayData)
        
        print("bardisplay")
    }
 */
  
    
    func loadBarDisplay() {
        
        print(waitsAt10)
        print("wait here")
        
        let sumAt11 = waitsAt11
        
        if sumAt11 > 0 {
            
            let sizeAt11 = sumAt11 * 20 + 20
            
            self.barDisplay3.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt11)).isActive = true
        }
            
        else {
            
            let sizeAt12 = 20
            
            self.barDisplay3.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
        }
    }
    
    func loadBarDisplay1() {
        
        let sumAt12 = waitsAt12
        
        if sumAt12 > 0 {
            
            let sizeAt12 = sumAt12 * 20 + 20
            
            self.barDisplay2.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
            
        }
            
        else {
            
            let sizeAt12 = 20
            
            self.barDisplay2.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
        }
    }
    func loadBarDisplay2() {
        
        let sumAt1 = waitsAt1
        
        if sumAt1 > 0 {
            
            let sizeAt1 = sumAt1 * 20 + 20
            
            self.barDisplay1.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt1)).isActive = true
            
            UIView.animate(withDuration: 1.0, animations: {
                self.barDisplay1.layoutIfNeeded()
            })
            
        }
        else {
            
            let sizeAt1 = 20
            
            self.barDisplay1.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt1)).isActive = true
        }
    }
    
    func loadBarDisplay3() {
        
        
        let sumAt3 = waitsAt3
        
        if sumAt3 > 0 {
            
            let sizeAt3 = sumAt3 * 20 + 20
            
            self.barDisplay10.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt3)).isActive = true
            
            UIView.animate(withDuration: 3.0, animations: {
                self.barDisplay10.layoutIfNeeded()
            })
        }
            
        else {
            
            let sizeAt3 = 20
            
            self.barDisplay10.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt3)).isActive = true
        }
    }
    func loadBarDisplay4() {
        
        
        let sumAt4 = waitsAt4
        
        if sumAt4 > 0 {
            
            let sizeAt4 = sumAt4 * 20 + 20
            
            self.barDisplay10.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt4)).isActive = true
            
            UIView.animate(withDuration: 3.0, animations: {
                self.barDisplay10.layoutIfNeeded()
            })
        }
            
        else {
            
            let sizeAt4 = 20
            
            self.barDisplay10.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt4)).isActive = true
        }
    }
    func loadBarDisplay5() {
        
        let sumAt5 = waitsAt5
        
        if sumAt5 > 0 {
            
            let sizeAt5 = sumAt5 * 20 + 20
            
            self.barDisplay9.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt5)).isActive = true
            
            UIView.animate(withDuration: 3.0, animations: {
                self.barDisplay9.layoutIfNeeded()
            })
        }
            
        else {
            
            let sizeAt5 = 20
            
            self.barDisplay9.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt5)).isActive = true
        }
    }
    
    func loadBarDisplay10() {
        
        
        let sumAt6 = waitsAt6
        
        if sumAt6 > 0 {
            
            let sizeAt6 = sumAt6 * 20 + 20
            
            self.barDisplay8.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt6)).isActive = true
            
            UIView.animate(withDuration: 3.0, animations: {
                self.barDisplay8.layoutIfNeeded()
            })
        }
            
        else {
            
            let sizeAt6 = 20
            
            self.barDisplay8.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt6)).isActive = true
            
            UIView.animate(withDuration: 1.0, animations: {
                self.barDisplay8.layoutIfNeeded()
            })
        }
        
    }
    func loadBarDisplay6() {
        
        let sumAt7 = waitsAt7
        
        if sumAt7 > 0 {
            
            let sizeAt7 = sumAt7 * 20 + 20
            
            self.barDisplay7.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt7)).isActive = true
            
            UIView.animate(withDuration: 3.0, animations: {
                self.barDisplay7.layoutIfNeeded()
            })
        }
            
        else {
            
            let sizeAt7 = 20
            
            self.barDisplay7.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt7)).isActive = true
        }
    }
    func loadBarDisplay7() {
        
        let sumAt8 = waitsAt8
        
        if sumAt8 > 0 {
            
            let sizeAt8 = sumAt8 * 20 + 20
            
            self.barDisplay6.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt8)).isActive = true
            
            UIView.animate(withDuration: 3.0, animations: {
                self.barDisplay6.layoutIfNeeded()
            })
        }
            
        else {
            
            let sizeAt8 = 20
            
            self.barDisplay6.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt8)).isActive = true
            
            UIView.animate(withDuration: 4.0, animations: {
                self.barDisplay6.layoutIfNeeded()
            })
        }
    }
    
    func loadBarDisplay8() {
        
        
        let sumAt9 = waitsAt9
        
        if sumAt9 > 0 {
            
            let sizeAt9 = sumAt9 * 20 + 20
            
            self.barDisplay5.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt9)).isActive = true
        
        }
            
        else {
            
            let sizeAt9 = 20
            
            self.barDisplay5.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt9)).isActive = true
            
            UIView.animate(withDuration: 3.0, animations: {
                self.barDisplay5.layoutIfNeeded()
            })
        }
    }
    
    func loadBarDisplay9() {
        
        
        let sumAt10 = waitsAt10
        
        if sumAt10 > 0 {
            
            let sizeAt10 = sumAt10 * 20 + 20
            
            self.barDisplay4.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt10)).isActive = true
        
            
        }else {
            
            let sizeAt10 = 20
            
            self.barDisplay4.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt10)).isActive = true
        }
    }
    
    //OLD CODE USED FOR CLEARING THE TABLE THAT NO LONGER EXISTS
  /*  func ClearingTable() {
        for rating in ratings {
            let indexPath = ratings.index(of: rating)
            let time = rating.timeIntervalSinceNow
            let timeInterval = time?.timeIntervalSinceNow
            let stringTime = stringSecondaryFromTimeInterval(interval: timeInterval!)
            print(stringTime)
            print("stringtime")
            if stringTime <= 2 {
                ratings.append(rating)
                print("inside constraint")
            }
            else {
                print("not inside")
            }
        }
        tableView.reloadData()
    }
 */
    
    //MAP ANNOTATIONS
    func mapDetails(){
        var locationAnnotation = MKPointAnnotation()
        
        let latitude = Location?.latitude
        let longitude = Location?.longitude
        var coorindates: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!) }
        locationAnnotation.coordinate = coorindates
        locationAnnotation.title = Location?.locationNameLong
        var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(coorindates, 500, 500) }
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(locationAnnotation)
        
       // var annotation4 = MKPointAnnotation()
    //the previous way annotations were added to the map 10/16/17 CODING OUT BECAUSE OF NEWEST LOAD METHOD ---- ALL DATA FROM BEAU'S SIDE
      /*  switch self.navigationItem.title! {
        case "McGarvey's":
            var mcgraveys: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9783113, longitude: -76.48699980000004) }
            annotation4.coordinate = mcgraveys
            annotation4.title = "McGarvey's Saloon & Oyster Bar"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(mcgraveys, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        case "Acme Bar & Grill":
            var acme: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.977616, longitude: -76.489920) }
            annotation4.coordinate = acme
            annotation4.title = "Acme Bar & Grill"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(acme, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        case "Armadillos Restaurant":
            var armadillos: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9779735, longitude: -76.48648589999999) }
            annotation4.coordinate = armadillos
            annotation4.title = "Armadillos Restaurant"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(armadillos, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        case "Dock Street Bar & Grill":
            var dockStreet: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978029, longitude: -76.486557) }
            annotation4.coordinate = dockStreet
            annotation4.title = "Dock Street Bar & Grill"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(dockStreet, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        case "Pusser's Caribbean Grille":
            var pussers: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9757627, longitude: -76.48553370000002) }
            annotation4.coordinate = pussers
            annotation4.title = "Pusser's Caribbean Grille"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(pussers, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        case "The Federal House":
            var FedHouse: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.978121, longitude: -76.487504) }
            annotation4.coordinate = FedHouse
            annotation4.title = "The Federal House"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(FedHouse, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        case "RJ Bentley's Restaurant":
            var FedHouse: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.980481, longitude: -76.937557) }
            annotation4.coordinate = FedHouse
            annotation4.title = "RJ Bentley's Restaurant"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(FedHouse, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        case "Cornerstone Grill & Loft":
            var FedHouse: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9806637, longitude: -76.93757349999998) }
            annotation4.coordinate = FedHouse
            annotation4.title = "Cornerstone Grill & Loft"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(FedHouse, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        case "Terrapin's Turf":
            var FedHouse: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9811964, longitude: -76.93839919999999) }
            annotation4.coordinate = FedHouse
            annotation4.title = "Terrapin's Turf"
            var region: MKCoordinateRegion { return MKCoordinateRegionMakeWithDistance(FedHouse, 1000, 1000) }
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(annotation4)
        default:
            print("no location")
         }
        */
        //Has been coded out forever
        /*var mcgraveys: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9783113, longitude: -76.48699980000004) }
         annotation4.coordinate = mcgraveys
         annotation4.title = "McGarvey's Saloon & Oyster Bar"
         mapView.addAnnotation(annotation4)
         */
    }
    
    private func animateBars() {
        
        //ATTEMPTING TO ANIMATE THE LOAD FOR THE BAR GRAPH DISPLAY BARS
  /*      let sizeAt12 = 100
        
      //  barDisplay1.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
        
        UIView.animate(withDuration: 1.0, animations: {
            self.barDisplay1.layoutIfNeeded()
        })
        
      //  barDisplay2.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
        UIView.animate(withDuration: 1.0, animations: {
            self.barDisplay2.layoutIfNeeded()
        })
        
     //   barDisplay3.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
        
        UIView.animate(withDuration: 1.0, animations: {
            self.barDisplay3.layoutIfNeeded()
        })
    
      //  barDisplay4.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
      //  barDisplay5.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
      //  barDisplay6.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
      //  barDisplay7.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
      //  barDisplay8.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
      //  barDisplay9.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
      //  barDisplay10.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt12)).isActive = true
 
        NewDataLoad2()
        */
    }
    
    func LoadingAllSpecials() {
        
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
                //INITIAL ACCESS POINT FOR DATA
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
                    //NOW ENTERING THE OBJECTS THAT MAKE UP THE ARRAY "{'':""}"
                    guard let dictionary = object as? [String: Any] else {
                        print("error")
                        return
                    }
                    print("inside here")
                    print(dictionary)
                    
                    //*EXAMPLE*METHOD FOR GETTING THE ESTIMATED WAIT AT 17
                    /*
                     guard let nestedDictionary = dictionary["estimated"] as? [String: Any] else {
                     print("error")
                     return
                     }
                     print(nestedDictionary)
                     print("nested here")
                     
                     guard let number = nestedDictionary["17"] as? String else {
                     print("error")
                     return
                     }
                     // access individual value in dictionary
                     print(number)
                     */
                    
                    guard let name = dictionary["locationName"] as? String, //Location name accessed
                        let recent = dictionary["recent"] as? String, //recent post accessed as string
                        let lastUpdated = dictionary["lastUpdated"] as? String, //recent post time accessed as string
                        let special = dictionary["specials"] as? String,
                        let longName = dictionary["longName"] as? String //recent post time accessed as string
                        else {
                            print("error")
                            return
                    }
                    //if the location out of the lists of locations is equal to the navigation controller then
                    if longName == self.navigationItem.title {
                        
                        
                        self.fullSpecialsString = special
                        self.loadingSpecials()
                        print(special)
                        print("special is above")
                        
                        //making the recent post into an integer
                        //  let numberRecent = Int(recent)
                        //setting the image number as the recent post and the reloading it on the main thread
                        //  self.imageNumber = numberRecent
                        
                        //  DispatchQueue.main.async() { self.updateCircleRating() }
                        //   print(numberRecent)
                        //   print("recent number")
                        
                    }
                    
                    // guard let Acme = location(detail1: name, detail2: name, special: self.AcmeSpecial, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: lastUpdated, phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: numberRecent!, ratings: self.AcmeDataPiece) else {
                    //    fatalError("Unable to instantiate location2")
                    // }
                    //  self.locations.append(Acme)
                    // self.tableView.reloadData()
                }
                //ACCESSSING ALL ESTIMATED WAIT DATA
                for object in array {
                    
                    guard let dictionary = object as? [String: Any] else {
                        print("error")
                        return
                    }
                    print("inside here")
                    print(dictionary)
                    
                    guard let longName = dictionary["longName"] as? String else {
                        print("error")
                        return
                    }
                    
                    print("inside here")
                    print(longName)
                    
                    if longName == self.navigationItem.title {
                        
                        
                        /*   guard let nestedDictionary = dictionary["estimated"] as? [String: Any] else {
                         print("error")
                         return
                         }
                         
                         print(nestedDictionary)
                         print("nested here")
                         
                         let hourArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14","15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
                         
                         // let average1 = Int()
                         
                         // let hourArray2 = [String: Int]()
                         
                         
                         for hour in hourArray {
                         
                         if let lastupdated = nestedDictionary[hour] as? String {
                         
                         /* guard let number = nestedDictionary[hour] as? String else {
                         print("error")
                         return
                         }
                         */
                         print(lastupdated)
                         print(hour)
                         
                         switch hour {
                         case "2":
                         print("average at 1")
                         print(lastupdated)
                         self.waitsAt1 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay2() }
                         case "14":
                         print("average at 2")
                         print(lastupdated)
                         self.waitsAt2 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay2() }
                         case "15":
                         print("average at 3")
                         print(lastupdated)
                         self.waitsAt3 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay3() }
                         case "16":
                         print("average at 4")
                         print(lastupdated)
                         self.waitsAt4 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay4() }
                         
                         case "17":
                         print("average at 5")
                         print(lastupdated)
                         self.waitsAt5 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay5() }
                         case "18":
                         print("average at 6")
                         print(lastupdated)
                         self.waitsAt6 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay10() }
                         case "19":
                         print("average at 7")
                         print(lastupdated)
                         self.waitsAt7 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay6() }
                         case "20":
                         print("average at 8")
                         print(lastupdated)
                         self.waitsAt8 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay7() }
                         case "21":
                         print("average at 9")
                         print(lastupdated)
                         self.waitsAt9 = Int(lastupdated)!
                         DispatchQueue.main.async() { self.loadBarDisplay8() }
                         case "22":
                         print("average at 10")
                         print(lastupdated)
                         self.waitsAt10 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay9() }
                         case "23":
                         print("average at 11")
                         print(lastupdated)
                         self.waitsAt11 = Int(lastupdated)!
                         DispatchQueue.main.async() {
                         self.loadBarDisplay() }
                         case "0":
                         print("average at 12")
                         print(lastupdated)
                         self.waitsAt12 = Int(lastupdated)!
                         DispatchQueue.main.async() {  self.loadBarDisplay1() }
                         default:
                         print("not a real time")
                         }
                         
                         DispatchQueue.main.async() { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
                         }
                         */
                    }
                }
                // access individual value in dictionary
                // print(number)
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
        task.resume()
    }
    
    private func loadingSpecials() {
        //  let firstDayIndex = fullSpecialsString.index(of: ":")!
        //  let firstDay = fullSpecialsString[...firstDayIndex]
        let count = fullSpecialsString.components(separatedBy: "|")
        for special in count {
            
            let oneSpecial = special.components(separatedBy: ":")
            let day = oneSpecial.first!
            let actualSpecial = oneSpecial.last!
            
            print(oneSpecial)
            print(day)
            print(actualSpecial)
            
            let fullSpecial = Special(name: day, details: actualSpecial)!
            Specials.append(fullSpecial)
            DispatchQueue.main.async() {  self.tableView.reloadData() }
            
        }
        print(count)
        //    print(firstDay)
        //   print(firstDayIndex)
    }
        
}




