//
//  LocationDetailViewController.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import CoreLocation
import os.log

class LocationDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var detail1Lbl: UILabel!
    @IBOutlet weak var detail2Lbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adressLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var locatingImage: UIImageView!
    
    var Location: location?
    
    var ratings = [rating]()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedRatings = loadRatings() {
            ratings += savedRatings
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let location = Location {
            detail1Lbl.text = location.detail1
            detail2Lbl.text = location.detail2
            locatingImage.image = location.locationImagine
            ratings = location.ratingList as! [rating]
            navigationItem.title = location.detail1
            phoneLbl.text = location.phoneNumber
            adressLbl.text = location.address
        }

        // Do any additional setup after loading the view.
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
        return ratings.count
        
    }
   
    /*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ratings.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
  */
    /*
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view ells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RatingTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RatingTableViewCell
        
        // Fetches the appropriate day for the data source laout
        let rating = ratings[indexPath.row]
        
        cell.timeLbl.text = rating.time
        
        cell.sliderLbl.text = String(rating.slider) + " minutes"
    
        //Determining the line status and adding a color to go along with it: red- very Slow, slow/fast - white, very fast - green
        if rating.lineRating == 0 {
            cell.infoLbl.text = "Very fast"
            cell.backgroundColor = UIColor(red: 0.1, green: 1.0, blue: 0.1, alpha: 1.0)
        }
        if rating.lineRating == 1 {
            cell.infoLbl.text = "fast"
            cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        if rating.lineRating == 2 {
            cell.infoLbl.text = "slow"
            cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        if rating.lineRating == 3 {
            cell.infoLbl.text = "Very slow"
            cell.backgroundColor = UIColor(red: 1.0, green: 0.1, blue: 0.1, alpha: 1.0)

        }
        
        cell.commentLbl.text = "comments: " + rating.comments
        
        return cell
    }

    

    // MARK: - Navigation
    
    @IBAction func unwindToRatingList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RatingViewController, let rating = sourceViewController.Rating {
            
            // Add a new rating.
             let newIndexPath = IndexPath(row: ratings.count, section: 0)
            

            ratings.insert(rating, at: ratings.count-ratings.count)
            //Insert into the table
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            //Reloads table data so it is ordered from most recent at the top
            tableView.reloadData()
            
        //This following was orginally how a new rating was added to the array of ratings and then displayed in table.
            
            /*
            ratings.append(rating)
            tableView.insertRows(at: [newIndexPath], with: .top)
            */
            
        }
        saveRatings()
        
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
     
            let detail1 = detail1Lbl.text ?? ""
            let detail2 = detail2Lbl.text ?? ""
            let locationImage1 = locatingImage.image
            let ratingList = ratings as NSArray
            let address = adressLbl.text
            let phoneNumber = phoneLbl.text
        
            // Set the reting to be passed to LocationTableViewController after the unwind segue.
        Location = location(detail1: detail1, detail2: detail2, ratingList: ratingList, locationImagine: locationImage1!, address: address!, phoneNumber: phoneNumber!)
        
        saveRatings()
        }
    
    private func loadSample() {
        let rating1 = rating(time: "", lineRating: 1, slider: 1, comments: "")
        
        ratings += [rating1]
    }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    
    private func saveRatings() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ratings, toFile: rating.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Ratings successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save ratings...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadRatings()-> [rating]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: rating.ArchiveURL.path) as? [rating]
    }
    
}
    
    




