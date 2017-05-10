
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

    //@IBOutlet weak var searchBar: UISearchBar!
    var timer: Timer!
    
    var locations = [location]()

    var location1ratings = [rating]()
    
    var ratings = [rating]()
    
    var ChipotleCircle: Int?
    
    var chipotleRatings = [rating]()
    var potbellyRatings = [rating]()
    var cornerstoneRatings = [rating]()
    var bentleysRatings = [rating]()
    var terripansRatings = [rating]()
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
//var refreshControl: UIRefreshControl!

//var filteredLocations = [location.PropertyKey.detail1]
//let filteredLocation = [String]()
//var resultSeachController = UISearchController()
var locationList: [location] = [location]()
var locationSearchingList: [location] = [location]()


    
    var isSearching: Bool = false
    
    let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
    
       private func loadData1() {
        
        print("load started")
        
        //  var time1 = NSDate()
        // var comments1 = String()
        // var locationName1 = String()
        // var ratingId1 = String()
        // var circleRating1 = Int()
        
        var task: URLSessionDataTask
        
        // Add one parameter
        let urlWithParams = scriptURL
        
        let myUrl = NSURL(string: urlWithParams);
        
        let request = NSMutableURLRequest(url: myUrl as! URL);
        
        request.httpMethod = "GET"
        
        print("load1.5")
        // ChipotleCircle = 3
        
        task = URLSession.shared.dataTask(with: request as URLRequest) {
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
        
                guard let array = json as? [Any] else {
                    print("error")
                    return
                }
                    guard let firstObject = array.first else {
                        print("error")
                        return
                }
                        
                    guard let dictionary = firstObject as? [String: Any] else {
                            
                            print("error")
                            return
                        }
                        
                        guard let circleRating = dictionary["circleRating"] as? String,
                            let lineRating = dictionary["lineRating"] as? String,
                            let Time = dictionary["timeDate"] as? String,
                            let location = dictionary["locationName"] as? String,
                            let comments = dictionary["comments"] as? String
                            else {
                                print("error")
                                return
                            }
            
            
            self.ChipotleCircle = Int(circleRating)!
            self.sampleLocations()
       //  self.tableView.reloadData()
           // self.sampleLocations()
         //   self.sampleLocations()
            
            
            }
        
        task.resume()
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // loadData()
        
      //  ChipotleCircle = 1
        

       // self.searchBar.delegate = self
        /*
        self.resultSeachController = UISearchController(searchResultsController: nil)
        self.resultSeachController.searchResultsUpdater = self
        self.resultSeachController.dimsBackgroundDuringPresentation = false
        self.resultSeachController.searchBar.sizeToFit()
*/
        //self.tableView.tableHeaderView = self.resultSeachController.searchBar

       // self.tableView.reloadData()

        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        
 // loadData()
        
      //  ChipotleCircle == 2
        //ChipotleCircle = 2
   
        loadData1()
       // sampleLocations()
        
   
     
        
        //if let savedRatings = loadRatings() {
            //  loadData()
         // locations += savedRatings
        //     print("true")
     //  }
    
        print(chipotleRatings)
   
   
        let currentDate = NSDate()
        print(currentDate)
        
    //     self.searchBar.delegate = self
        
        locationList = locations
        
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
        /*
        if self.resultSeachController.isActive {
            return self.filteredLocations.count
            
        }
        else {
            return self.locations.count
        } 
         */
        
        if self.isSearching == true {
            return locationSearchingList.count
        } else {
            //locationList.reverse()
            return locations.count
        }
        
      //  return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Location"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LocationTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let location = locations[indexPath.row]
        
        if self.isSearching == true {
            
            let searchLocation = locationSearchingList[indexPath.row]

            
            cell.detail1Lbl.text = searchLocation.detail1
            cell.detail2Lbl.text = searchLocation.detail2
            cell.circleRating.rating = searchLocation.llLocation
            cell.locationImagine.image = searchLocation.locationImagine
            cell.segmentedControl.selectedSegmentIndex = searchLocation.qLocation

        } else {
        
            cell.detail1Lbl.text = location.detail1
            cell.detail2Lbl.text = location.detail2
            cell.circleRating.rating = location.llLocation
            cell.locationImagine.image = location.locationImagine
            cell.segmentedControl.selectedSegmentIndex = location.qLocation
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
            
            if self.isSearching == true {
                
                let searchLocation = locationSearchingList[indexPath.row]
                
                locationDetailViewController.Location = searchLocation
                locationDetailViewController.directPost = 0
               
                
            } else {
            
            let selectedLocation = locations[indexPath.row]
            locationDetailViewController.Location = selectedLocation
            locationDetailViewController.directPost = 0
            }
           //tableView.reloadData()
            // self.isSearching = false
       
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
    /*
    private func loadData() {
        
        print("load started")
        
      //  var time1 = NSDate()
       // var comments1 = String()
       // var locationName1 = String()
       // var ratingId1 = String()
       // var circleRating1 = Int()
        
        let scriptURL = "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/getData.php"
        
        // Add one parameter
        let urlWithParams = scriptURL
        
        let myUrl = NSURL(string: urlWithParams);
        
        let request = NSMutableURLRequest(url: myUrl as! URL);
        
        request.httpMethod = "GET"
        
        print("load1.5")
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
            
            if let array = json as? [Any] {
                
                if let firstObject = array.first {
                    
                    if let dictionary = firstObject as? [String: Any] {
                        
                        if let number1 = dictionary["circleRating"] as? String {
                            
                            print("made it")
                            
                            self.ChipotleCircle = 1
                            print(self.ChipotleCircle)
                            
                        }
                        print("double check")
                      print(self.ChipotleCircle)
                    }
                        print("triple check")
                     print(self.ChipotleCircle)
                }
                    print("4 check")
                 print(self.ChipotleCircle)
            }
                print("5 check")
             print(self.ChipotleCircle)
        }
        print("6 check")
        print(self.ChipotleCircle)
             task.resume()
        print("7 check")
        print(self.ChipotleCircle)
        }

    
        */
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
 
        print("load2")
            if let array = json as? [Any] {
                
                if let firstObject = array.first {
                    
                    if let dictionary = firstObject as? [String: Any] {
                        
                        if let number = dictionary["circleRating"] as? String {
                            
                            print("made it")
                            
                            self.ChipotleCircle = 1
                            
                            // access individual value in dictionary
                        }
                    }
                    // access individual object in array
                
                /*
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
                                   self.ChipotleCircle = Int(circleRating)!
                                    
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
                     /*   //var Filter = self.detail1Lbl.text!
                        switch Filter {
                        case "R J Bentley's Restaurant":
                            if locationName1 == "Bentley's" {
                                
                            }
                        case "Chipotle Mexican Grill":
                            if locationName1 == "Chipotle" {
                                self.ratings.append(rating1!)
                                self.ratings.reverse()
                                self.tableView.reloadData()
                            }
                            
                        case "Cornerstone Grill & Loft":
                            if locationName1 == "Cornerstone" {
                                self.ratings.append(rating1!)
                                self.ratings.reverse()
                                self.tableView.reloadData()
                            }
                        case "Terrapins Turf":
                            if locationName1 == "Terrapin Turf" {
                                self.ratings.append(rating1!)
                                self.ratings.reverse()
                                self.tableView.reloadData()
                            }
                        case "Potbelly Sandwich Shop":
                            if locationName1 == "Potbelly" {
                                self.ratings.append(rating1!)
                                self.ratings.reverse()
                                self.tableView.reloadData()
                            }
                        default:
                            self.ratings.reverse()
                            self.tableView.reloadData()
                            */
                 ]
                        */
                
                    }
                }
            }
    

    task.resume()
        
    print(self.chipotleRatings)
        
    }
 */
    
    private func sampleLocations() {
        
        //currently loads blank arrays into the LocaitonDetailViewController table view when a location is selceted.  Thinking we would say ratingList: name of databased containing the ratings to be entered into the table.  Until we change the the rating list from an empty array every time the app is restarted it will continue to load with no ratings.
    //  loadData()
           let currentDate = NSDate()
        //data()
    
       //loadData1()
        
      //  let rating1 = rating(time: "", lineRating: 1, circleRating: 1, comments: "", timeIntervalSinceNow: currentDate)
      //  let rating2 = rating(time: "", lineRating: 2, circleRating: 2, comments: "", timeIntervalSinceNow: currentDate)
      //  let rating3 = rating(time: "", lineRating: 3, circleRating: 3, comments: "", timeIntervalSinceNow: currentDate)
        
       // chipotleRatings += [rating1!, rating2!, rating3!]
        
        guard let Chipotle = location(detail1: "Chipotle Mexican Grill", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Chipotle"), address: "7332/BaltimoreAve", phoneNumber: "2405820015", displayedAddress: "7332 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(240) 582-0015", llLocation: self.ChipotleCircle!, qLocation: 0, ratings: chipotleRatings) else {
            fatalError("Unable to instantiate loction1")
        }
        print("check")
        print(self.ChipotleCircle)
        guard let Bentleys = location(detail1: "R J Bentley's Restaurant", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "bently's"), address: "7323/BaltimoreAve", phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: 2, qLocation: 0, ratings: bentleysRatings) else {
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
        locationList = [Chipotle, Bentleys, CornerStone, TerrapiansTurf, PotBelly]
        locations.removeAll()
        locations += [Chipotle, Bentleys, CornerStone, TerrapiansTurf, PotBelly]
        locations.sort  { $0.detail1 < $1.detail1 }
        tableView.reloadData()
        
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
                    
                    if Location.detail1 == "Chipotle Mexican Grill" {
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
    
  /*   @IBAction func unwindToLocationList(sender: UIGestureRecognizer) {
        if let sourceViewController = sender as? LocationDetailViewController, let Location = sourceViewController.Location {
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

        
    }*/
    
    
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
        loadData1()
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
    
   /*
    func updateSearchResults(for searchController: UISearchController) {

            self.filteredLocations.removeAll(keepingCapacity: false)
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[C] %@", searchController.searchBar.text!)
            let array = (self.locations as NSArray).filtered(using: searchPredicate)

            // self.filteredLocations =  array as filteredLocations
            self.tableView.reloadData()
        }
 */
    
        //Search Bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.searchBar.text!.isEmpty {

            // set searching false
            self.isSearching = false
            // reload table view
            self.tableView.reloadData()

        }else{

            // set searghing true
            self.isSearching = true

            // empty searching array
             self.locationSearchingList.removeAll(keepingCapacity: false)

            // find matching item and add it to the searcing array
            for i in 0..<locations.count {

                let listItem : location = locations[i]
                
                if listItem.detail1.lowercased().range(of: self.searchBar.text!.lowercased()) != nil {
                     if listItem.detail1.lowercased().range(of: "z") != nil {
                        self.locationSearchingList.append(listItem)
                    }
                    
                  //  self.locationSearchingList.append(locationList.)
                }
            }

            self.tableView.reloadData()
        }

}


// hide kwyboard when search button clicked
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.searchBar.resignFirstResponder()
    self.tableView.reloadData()

}

// hide keyboard when cancel button clicked
func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.searchBar.text = ""
    self.searchBar.resignFirstResponder()
    self.isSearching = false
    self.tableView.reloadData()
    tableView.reloadData()
}

 
    
    
}
