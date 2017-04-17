
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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
   
         sampleLocations()
        
        if let savedRatings = loadRatings() {
            locations += savedRatings
        }
   
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
    
    //MARK: Private methods
    private func sampleLocations(){
        
        //currently loads blank arrays into the LocaitonDetailViewController table view when a location is selceted.  Thinking we would say ratingList: name of databased containing the ratings to be entered into the table.  Until we change the the rating list from an empty array every time the app is restarted it will continue to load with no ratings.
        
        guard let Chipotle = location(detail1: "Chipolte Mexican Grill", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Chipotle"), address: "7332/BaltimoreAve", phoneNumber: "2405820015", displayedAddress: "7332 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(240) 582-0015", llLocation: 0, qLocation: "Chipotle+Mexican+Grill") else {
            fatalError("Unable to instantiate loction1")
        }
        guard let Bentleys = location(detail1: "R J Bentley's Restaurant", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "bently's"), address: "7323/BaltimoreAve", phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: 0, qLocation: "R+J+Bentley's+Restaurant") else {
            fatalError("Unable to instantiate location2")
        }
        guard let CornerStone = location(detail1: "Cornerstone Grill & Loft", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Cornerstone"), address: "7325/BaltimoreAve", phoneNumber: "3017797044", displayedAddress: "7325 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 779-7044", llLocation: 0, qLocation: "R+J+Bentley's+Restaurant") else {
            fatalError("Unable to instantiate location2")
        }
        guard let TerrapiansTurf = location(detail1: "Terrapins Turf", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Chipotle"), address: "4410/KnoxRd", phoneNumber: "3012778377", displayedAddress: "4410 Knox Rd, College Park, MD", displayedPhoneNumber: "(301) 277-8377", llLocation: 0, qLocation: "Terrapins+Turf") else {
                fatalError("Unable to instantiate location2")
        }
        guard let PotBelly = location(detail1: "Potbelly Sandwich Shop", detail2: "reload", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Potbelly"), address: "7422/BaltimoreAve", phoneNumber: "3012090635", displayedAddress: "7422 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 209-0635", llLocation: 0, qLocation: "Potbelly+Sandwich+Shop") else {
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
           // reloadInputViews()
            print("refresherRequest")
        
        }
    }
}
