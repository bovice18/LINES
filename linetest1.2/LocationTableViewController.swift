//
//  LocationTableViewController.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import os.log

class LocationTableViewController: UITableViewController {

    var locations = [location]()

    var location1ratings = [rating]()
    
    var ratings = [rating]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         sampleRatings()
        sampleLocations()
        
        if let savedRatings = loadRatings() {
            locations += savedRatings
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
        cell.locationImagine.image = location.locationImagine
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    //MARK: Private methods
    
    private func sampleLocations(){
        
        //currently loads blank arrays into the LocaitonDetailViewController table view when a location is selceted.  Thinking we would say ratingList: name of databased containing the ratings to be entered into the table.  Until we change the the rating list from an empty array every time the app is restarted it will continue to load with no ratings.
        
        guard let location1 = location(detail1: "Chipolte", detail2: "place1", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "Chipotle"), address: "College Park Shopping Center, 7332 Baltimore Ave, College Park, MD 20740", phoneNumber: "(240) 582-0015") else {
            fatalError("Unable to instantiate loction1")
        }
        guard let location2 = location(detail1: "Bentley's", detail2: "place2", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "bently's"), address: "Address: 7323 Baltimore Ave. College Park, MD 20740", phoneNumber: "(301)277-8898") else {
            fatalError("Unable to instantiate location2")
        }

        
        locations += [location1, location2]
    }

    private func sampleRatings(){
        let rating1 = rating(time: "g", lineRating: 1, slider: 1, comments: "")
        let rating2 = rating(time: "f", lineRating: 1, slider: 1, comments: "")
        let rating3 = rating(time: "f", lineRating: 1, slider: 1, comments: "")
        let rating4 = rating(time: "f", lineRating: 1, slider: 1, comments: "")
        
       // location1ratings += [rating1, rating2, rating3, rating4]
        
     
    }
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? LocationDetailViewController, let Location = sourceViewController.Location {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // Update an existing meal.
                    locations[selectedIndexPath.row] = Location
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
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
    
}






