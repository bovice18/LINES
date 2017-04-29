
//
//  LocationTableViewController.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import os.log

class LocationTableViewController: UITableViewController, UISearchBarDelegate {

    var timer: Timer!
    
    var locations = [location]()

    var location1ratings = [rating]()
    
    var ratings = [rating]()
    
    var chipotleRatings = [rating]()
    var potbellyRatings = [rating]()
    var cornerstoneRatings = [rating]()
    var bentleysRatings = [rating]()
    var terripansRatings = [rating]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  loadData()
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        
  //loadData()
   
        sampleLocations()
   
        
        
        if let savedRatings = loadRatings() {
            //  loadData()
          locations += savedRatings
        //     print("true")
       }
    
        print(chipotleRatings)
   
   
        let currentDate = NSDate()
        print(currentDate)
        
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
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Location"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LocationTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let location = locations[indexPath.row]
        
            cell.detail1Lbl.text = location.detail1
            cell.detail2Lbl.text = location.detail2
            cell.circleRating.rating = location.llLocation
            cell.locationImagine.image = location.locationImagine
        cell.segmentedControl.selectedSegmentIndex = location.qLocation
        
        return cell
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
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedLocationCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
       
            
            let selectedLocation = locations[indexPath.row]
            locationDetailViewController.Location = selectedLocation
            locationDetailViewController.directPost = 0
            
            case "JoinTheLine":
            
                guard let locationDetailViewController = segue.destination as? LocationDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            
                var indexPath: NSIndexPath!
                
                guard let button = sender as? UIButton  else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                    if let superview = button.superview {
                        if let cell = superview.superview as? LocationTableViewCell {
                            indexPath = tableView.indexPath(for: cell) as NSIndexPath!
                        }
                    }
                let selectedLocation = locations[indexPath.row]
                locationDetailViewController.Location = selectedLocation
    
                locationDetailViewController.directPost = 1
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
 //   var rating5: rating?
    
    //MARK: Private methods
    private func loadData() {
        
        
        var time1 = NSDate()
        var comments1 = String()
        var locationName1 = String()
        var ratingId1 = String()
        var circleRating1 = Int()
        
        
        let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
        
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
            
            print("working")
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            /*
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
            */
        
            if let array = json as? [Any] {
                print("working")
                for object in array {
             
                    
                    if let dictionary = object as? [String: Any] {
               
                        
                        if let ratingId = dictionary["ratingId"] as? String {
                            // access individual value in dictionary
                            print(ratingId)
                            ratingId1 = ratingId
                            print("so far")
                        }
                        
                            if let comments = dictionary["comments"] as? String {
                                // access individual value in dictionary
                                print(comments)
                                comments1 = comments
                            }
                            
                                if let circleRating = dictionary["circleRating"] as? String {
                                    // access individual value in dictionary
                                    print(circleRating)
                                    circleRating1 = Int(circleRating)!
                                }
                                    if let locationName = dictionary["locationName"] as? String {
                                        // access individual value in dictionary
                                        print(locationName)
                                        locationName1 = locationName
                                    }
                                        if let timeDate = dictionary["timeDate"] as? NSDate {
                                            // access individual value in dictionary
                                            print(timeDate)
                                            time1 = timeDate
                                            
                                        }
                    }
                }
            }
        }
        let rating6 = rating(locationName: locationName1, time: locationName1, lineRating: circleRating1, circleRating: circleRating1, comments: comments1, timeIntervalSinceNow: time1)
                                        
                                        print("working")
                                        chipotleRatings.append(rating6!)
                        
                                        var FilterRating = locationName1
                                        switch FilterRating {
                                        case "Chipotle":
                                          //  self.chipotleRatings += [rating6!]
                                           // self.chipotleRatings.insert(rating6!, at: 0)
                                            chipotleRatings.append(rating6!)
                                            tableView.reloadData()
                            
    
                                          //  self.chipotleRatings.insert(rating6!)
                                            
                                            print("inserted Chipolte Rating")
                                            
                                            
                                        case "Bentley's":
                                            bentleysRatings.append(rating6!)
                                            print("inserted Bentley's Rating")
                                            
                                        default:
                                            ratings.append(rating6!)
                                            print("defualt")
                                            
                                        }
                                        
                                        //self.ratings.append(rating1!)
                                        
                                        //  self.tableView.reloadData()
                                        print(self.ratings)
                                        print(self.chipotleRatings)
                                        
                                        print(self.bentleysRatings)
                                        print("working")
                    
                    print("object")
                    //print(object)
                    // access all objects in array

        task.resume()
        print(self.chipotleRatings)
        
    }
    
    private func sampleLocations() {
        
        //currently loads blank arrays into the LocaitonDetailViewController table view when a location is selceted.  Thinking we would say ratingList: name of databased containing the ratings to be entered into the table.  Until we change the the rating list from an empty array every time the app is restarted it will continue to load with no ratings.
       // loadData()
           let currentDate = NSDate()
        //data()
        //loadData()
        
        
      //  let rating1 = rating(time: "", lineRating: 1, circleRating: 1, comments: "", timeIntervalSinceNow: currentDate)
      //  let rating2 = rating(time: "", lineRating: 2, circleRating: 2, comments: "", timeIntervalSinceNow: currentDate)
      //  let rating3 = rating(time: "", lineRating: 3, circleRating: 3, comments: "", timeIntervalSinceNow: currentDate)
        
       // chipotleRatings += [rating1!, rating2!, rating3!]
        
        guard let Chipotle = location(detail1: "Chipotle Mexican Grill", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Chipotle"), address: "7332/BaltimoreAve", phoneNumber: "2405820015", displayedAddress: "7332 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(240) 582-0015", llLocation: 0, qLocation: 0, ratings: chipotleRatings) else {
            fatalError("Unable to instantiate loction1")
        }
        print("check")
        print(chipotleRatings)
        guard let Bentleys = location(detail1: "R J Bentley's Restaurant", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "bently's"), address: "7323/BaltimoreAve", phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: 0, qLocation: 0, ratings: bentleysRatings) else {
            fatalError("Unable to instantiate location2")
        }
        guard let CornerStone = location(detail1: "Cornerstone Grill & Loft", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Cornerstone"), address: "7325/BaltimoreAve", phoneNumber: "3017797044", displayedAddress: "7325 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 779-7044", llLocation: 0, qLocation: 0, ratings: ratings) else {
            fatalError("Unable to instantiate location2")
        }
        guard let TerrapiansTurf = location(detail1: "Terrapin Turf", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Chipotle"), address: "4410/KnoxRd", phoneNumber: "3012778377", displayedAddress: "4410 Knox Rd, College Park, MD", displayedPhoneNumber: "(301) 277-8377", llLocation: 0, qLocation: 0, ratings: ratings) else {
                fatalError("Unable to instantiate location2")
        }
        guard let PotBelly = location(detail1: "Potbelly Sandwich Shop", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Potbelly"), address: "7422/BaltimoreAve", phoneNumber: "3012090635", displayedAddress: "7422 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 209-0635", llLocation: 0, qLocation: 0, ratings: ratings) else {
            fatalError("Unable to instantiate location2")
        }
        locations += [Chipotle, Bentleys, CornerStone, TerrapiansTurf, PotBelly]
    }
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? LocationDetailViewController, let Location = sourceViewController.Location {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // Update an existing meal.
                    locations[selectedIndexPath.row] = Location
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                } else {
                    
                    var indexPath: NSIndexPath!
                    
                    let cell = LocationDetailViewController()
                    
                    if Location.detail1 == "Chipolte Mexican Grill" {
                        let indexPath1 = IndexPath(row: 0, section: 0)
                        
                        locations[indexPath1.row] = Location
                        tableView.reloadRows(at: [indexPath1], with: .none)
                    }
                    if Location.detail1 == "R J Bentley's Restuarant" {
                        let indexPath1 = IndexPath(row: 1, section: 0)
                        
                        locations[indexPath1.row] = Location
                        tableView.reloadRows(at: [indexPath1], with: .none)
                    }
                
                    if Location.detail1 == "Cornerstone Grill & Loft" {
                        let indexPath1 = IndexPath(row: 2, section: 0)
                        
                        locations[indexPath1.row] = Location
                        tableView.reloadRows(at: [indexPath1], with: .none)
                    }
                
                    if Location.detail1 == "Terrapins Turf" {
                        let indexPath1 = IndexPath(row: 3, section: 0)
                        
                        locations[indexPath1.row] = Location
                        tableView.reloadRows(at: [indexPath1], with: .none)
                    }
                
                    if Location.detail1 == "Potbelly Sandwich Shop" {
                        let indexPath1 = IndexPath(row: 4, section: 0)
                        
                        locations[indexPath1.row] = Location
                        tableView.reloadRows(at: [indexPath1], with: .none)
                    }
            }
        }
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
        //let locationdetailviewcontroller = LocationDetailViewController()
       // locationdetailviewcontroller.mostRecentTime()
      
        //LocationDetailViewController.stringFromTimeInterval(LocationDetailViewController)
       // reloadInputViews()
       // tableView.reloadData()
        loadData()
        timer =  Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(endOfWork), userInfo: nil, repeats: false)
        print("time set")
    }
    
    func endOfWork() {
        refreshControl!.endRefreshing()
    
        timer.invalidate()
        timer = nil
        print("end of work")
    }
    
    func data() {
        let currentDate = NSDate()
        
        
        //let newRating = rating(time: "", lineRating: 1, circleRating: 1, comments: "", timeIntervalSinceNow: currentDate)
        
        //chipotleRatings.append(newRating!)
        
        if chipotleRatings.count == 2 {
            //chipotleRatings.append(newRating!)
        }
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl!.isRefreshing {
            RefresherRequestForData()
           // reloadInputViews()
            print("refresherRequest")
        
        }
    }
    
   
    
    
    
    
}
