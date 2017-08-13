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

class LocationDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate,  MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer) {
        
        performSegue(withIdentifier: "Switch", sender: sender)
    }
    
    @IBOutlet weak var timeSincePostLbl: UILabel!
    
    @IBOutlet weak var LineImage: UIImageView!
    
    @IBOutlet weak var graphTitleLbl: UILabel!
    
    @IBOutlet weak var GraphDisplayView: UIView!
    
    @IBOutlet weak var FirstWhiteView: UIView!
    
    @IBOutlet weak var WaitSegmentedControl: UISegmentedControl!
    @IBAction func switchButtonPressed(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("Wait")
        case 1:
            print("Specials")
            performSegue(withIdentifier: "Switch", sender: sender)
        default:
            print("failed segment")
        }
    }
    
    @IBOutlet weak var joinTheLineButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var adressLbl: UILabel!
    
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var barDisplay1: UIView!
    
    @IBOutlet weak var barDisplay2: UIView!
    
    @IBOutlet weak var barDisplay3: UIView!
    
    @IBOutlet weak var barDisplay4: UIView!
    
    @IBOutlet weak var barDisplay5: UIView!
    
    @IBOutlet weak var barDisplay6: UIView!
    
    @IBOutlet weak var barDisplay7: UIView!
    
    @IBOutlet weak var barDisplay8: UIView!
    
    @IBOutlet weak var barDisplay9: UIView!
    
    @IBOutlet weak var barDisplay10: UIView!
    
    @IBOutlet weak var barDisplay11: UIView!
    
    @IBOutlet weak var barDisplay12: UIView!
    
    var MondayDeal: Special?
    
    var AllDeals = [Special]()
    
    var imageNumber: Int?
    
    var timeLblData: String?
    
    var Location: location?
    
    var ratings = [rating]()
    
    var specials = [Special]()
    
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
    
    var ratingsAt11 = [rating]()
    
    var ratingsAt12 = [rating]()
    
    var ratingsAt1 = [rating]()
    
    var ratingsAt2 = [rating]()
    
    var ratingsAt3 = [rating]()
    
    var ratingsAt4 = [rating]()
    
    var ratingsAt5 = [rating]()
    
    var ratingsAt6 = [rating]()
    
    var ratingsAt7 = [rating]()
    
    var BarDisplayData = [Int]()
    
    var BarDisplays = [BarDisplayDataPiece]()
    
    let locationManager = CLLocationManager()
    
    var directPost: Int?
    
    let FridayDeal = Special(name: "FRIDAY", details: "Mixed Drinks", Image: #imageLiteral(resourceName: "acme2"))
    
    @IBOutlet weak var coloredView: UIView!
    
    var refreshControl: UIRefreshControl!
    
    var timer: Timer!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
         mapView.delegate = self
    
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        //    self.locationManager.requestAlwaysAuthorization()
        // self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    
        
        
        AllDeals.append(FridayDeal!)
        
        NewLoadData()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
        
        view.sendSubview(toBack: blurEffectView)
        
        GraphDisplayView.layer.cornerRadius = 4
        
        FirstWhiteView.layer.cornerRadius = 4
        
        tableView.layer.cornerRadius = 4
        
        graphTitleLbl.layer.cornerRadius = 5
        
        if let location = Location {
            
            BarDisplays = location.ratings
            
            AllDeals = location.special
            
            print(location.ratings)
            
            print(BarDisplays.count)
            
            print(location.ratings.count)
            
            print(BarDisplays.first?.postTime as Any)
            
            print(BarDisplays.first?.waitTime as Any)
            
            print("target")
            
            navigationItem.title = location.detail1
            
            print("entered")
        }
        
        //   SortingBarDisplayData()
        
        let locationTableView = LocationTableViewController()
        
        let locationDetailView = LocationDetailViewController()
        
        let jointheline = UIStoryboardSegue.init(identifier: "JoinTheLine", source: locationTableView, destination: locationDetailView)
        
        jointheline.destination.navigationItem.title = "name"
        
        
        let title = (Location?.detail1)!
        
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
            
        default:
            
            UserDefaults.standard.set(0, forKey: "title")
            
            UserDefaults.standard.synchronize()
            
        }
        
        if directPost == 1 {
            
            performSegue(withIdentifier: "Post", sender: viewDidAppear(true))
            
        }
        
        barDisplay1.layer.cornerRadius = 4
        
        //    SortingBarDisplayData()
        
        //    loadBarDisplay()
        
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
        
        tableView.addSubview(refreshControl!)
        
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
        
        tableView.reloadData()
        
        mostRecentTime()
        
        // updateCircleRating()
        
        // ClearingTable()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllDeals.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view ells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "RatingTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RatingTableViewCell
        
        // Fetches the appropriate day for the data source laout
        let rating = AllDeals[indexPath.row]
        
        cell.detailsLabel.text = rating.details
        
        cell.LineImage.image = rating.Image
        
        cell.timeLbl.text = rating.name
        
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
    
    func changeTitleBack() {
        
        navigationItem.title = Location?.detail1
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // This method lets you configure a view controller before it's presented.
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let detail1 = Location?.detail1
        
        let detail2 = Location?.detail2
        
        let locationImage1 = Location?.locationImagine
        
        let ratingList = Location?.special
        
        let timeSinceLastPost = Location?.timeSinceLastPost
        
        let phoneNumber = Location?.phoneNumber
        
        let displayedAddress = Location?.displayedPhoneNumber
        
        let displayedPhoneNumber = Location?.displayedAddress
        
        let llLocation = Location?.llLocation
        
        let ratings1 = Location?.ratings
        
        // Set the reting to be passed to LocationTableViewController after the unwind segue.
        Location = location(detail1: detail1!, detail2: detail2!, special: ratingList!, locationImagine: locationImage1!, timeSinceLastPost: timeSinceLastPost!, phoneNumber: phoneNumber!, displayedAddress: displayedAddress!, displayedPhoneNumber: displayedPhoneNumber!, llLocation: llLocation!, ratings: ratings1!)
        
        
        //  loadData()
        
        NewLoadData()
        
        saveRatings()
        
        mostRecentTime()
        
        updateCircleRating()
        
        print(ratingList)
        
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
        
        if ratings.count >= 1 {
            
            let indexPath1 = NSIndexPath(row: 0, section: 0)
            
            let cellIdentifier = "RatingTableViewCell"
            
            let mostRecentRating = ratings[indexPath1.row]
            
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
        else {
            
            switch imageNumber {
                
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
            
        }
    }
    
    func mostRecentTime() {
        
        if ratings.count >= 1{
            
            let indexPath1 = NSIndexPath(row: 0, section: 0)
            
            let cellIdentifier = "RatingTableViewCell"
            
            let mostRecentRating = ratings[indexPath1.row]
            
            let PostedDate = mostRecentRating.timeIntervalSinceNow
            
            let intervalSincePost = PostedDate?.timeIntervalSinceNow
            
            let postedDate = stringFromTimeInterval(interval: intervalSincePost! * -1)
            
            timeSincePostLbl.text = postedDate
        }
        else {
            timeSincePostLbl.text = timeLblData
        }
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
    
    func loadData() {
        
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
        }
            
        else {
            
            let sizeAt6 = 20
            
            self.barDisplay8.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt6)).isActive = true
        }
        
    }
    func loadBarDisplay6() {
        
        let sumAt7 = waitsAt7
        
        if sumAt7 > 0 {
            
            let sizeAt7 = sumAt7 * 20 + 20
            
            self.barDisplay7.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt7)).isActive = true
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
        }
            
        else {
            
            let sizeAt8 = 20
            
            self.barDisplay6.heightAnchor.constraint(equalToConstant: CGFloat(sizeAt8)).isActive = true
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
    
    func ClearingTable() {
        
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
    
    
    //Map Annotations
    
    func mapDetails(){
        
        var annotation4 = MKPointAnnotation()
        
       switch self.navigationItem.title! {
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
            
        default:
            print("no location")
            
        }
        
        /*var mcgraveys: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 38.9783113, longitude: -76.48699980000004) }
         
         annotation4.coordinate = mcgraveys
         
         annotation4.title = "McGarvey's Saloon & Oyster Bar"
         
         mapView.addAnnotation(annotation4)
         */
    }


    
}




