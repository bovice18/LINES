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

    @IBOutlet weak var progressViewer1: UIProgressView!
    @IBOutlet weak var detail1Lbl: UILabel!
    @IBOutlet weak var progressViewer3: UIProgressView!
    @IBOutlet weak var progressViewer2: UIProgressView!
    @IBOutlet weak var progressViewer4: UIProgressView!
    @IBOutlet weak var progressViewer5: UIProgressView!
    @IBOutlet weak var progressViewer6: UIProgressView!
    @IBOutlet weak var progressViewer7: UIProgressView!
    @IBOutlet weak var progressViewer8: UIProgressView!
    @IBOutlet weak var progressViewer9: UIProgressView!
    @IBOutlet weak var progressViewer10: UIProgressView!
    @IBOutlet weak var progressViewer11: UIProgressView!
    @IBOutlet weak var progressViewer12: UIProgressView!
    @IBOutlet weak var detail2Lbl: UILabel!
    @IBOutlet weak var joinTheLineButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adressLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var locatingImage: UIImageView!
    @IBOutlet weak var MapButton: UIButton!
    @IBOutlet weak var CallButton: UIButton!
    
    var Location: location?
    
    var ratings = [rating]()
    
    var ratingsAt11 = [rating]()
    var ratingsAt12 = [rating]()
    var ratingsAt1 = [rating]()
    var ratingsAt2 = [rating]()
    var ratingsAt3 = [rating]()
    var ratingsAt4 = [rating]()
    var ratingsAt5 = [rating]()
    var ratingsAt6 = [rating]()
    var ratingsAt7 = [rating]()
    
    var llLocation: String?
    
    var qllocation: String?
    
   // var postStatus = [post]()
    
    let locationManager = CLLocationManager()
    
    var directPost: Int?
    

    var refreshControl: UIRefreshControl!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationTableView = LocationTableViewController()
        let locationDetailView = LocationDetailViewController()
        let jointheline = UIStoryboardSegue.init(identifier: "JoinTheLine", source: locationTableView, destination: locationDetailView)
        
        if directPost == 1 {
            performSegue(withIdentifier: "Post", sender: viewDidAppear(true))
        }
        
        self.progressViewer1.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer1.transform = progressViewer1.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer2.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer2.transform = progressViewer2.transform.scaledBy(x: 1, y: 10)
        
        
        self.progressViewer3.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer3.transform = progressViewer3.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer4.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer4.transform = progressViewer4.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer5.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer5.transform = progressViewer5.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer6.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer6.transform = progressViewer6.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer7.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer7.transform = progressViewer7.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer8.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer8.transform = progressViewer8.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer9.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer9.transform = progressViewer9.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer10.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer10.transform = progressViewer10.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer11.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer11.transform = progressViewer11.transform.scaledBy(x: 1, y: 10)
        
        self.progressViewer12.transform = CGAffineTransform(rotationAngle: (CGFloat(-90) / CGFloat(180.0) * CGFloat(M_PI)))
        progressViewer12.transform = progressViewer12.transform.scaledBy(x: 1, y: 10)
        
        mostRecentTime()
    
        if let savedRatings = loadRatings() {
            ratings += savedRatings
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        
        if let location = Location {
            detail1Lbl.text = location.detail1
            detail2Lbl.text = location.detail2
            locatingImage.image = location.locationImagine
            ratings = location.ratingList as! [rating]
            navigationItem.title = location.detail1
           // phoneLbl.text = location.phoneNumber
           // adressLbl.text = location.address
          //  MapButton.setTitle(location.displayedAddress, for: .normal)
           // CallButton.setTitle(location.displayedPhoneNumber, for: .normal)
            llLocation = location.llLocation
            qllocation = location.qLocation
            
            print("entered")
        }
        //GRAPH setup- not connected to info yet
                let value1 = 0.7
                let value2 = 0.2
                let value3 = 0.4
                let value4 = 0.6
                let value5 = 0.7
                let value6 = 0.1
                let value7 = 0.9
                let value8 = 0.7
                let value9 = 0.5
                let value10 = 0.5
                let value11 = 0.2
                let value12 = 0.8
        
                self.progressViewer1.progress = Float(value1)
                self.progressViewer2.progress = Float(value2)
                self.progressViewer3.progress = Float(value3)
                self.progressViewer4.progress = Float(value4)
                self.progressViewer5.progress = Float(value5)
                self.progressViewer6.progress = Float(value6)
                self.progressViewer7.progress = Float(value7)
                self.progressViewer8.progress = Float(value8)
                self.progressViewer9.progress = Float(value9)
                self.progressViewer10.progress = Float(value10)
                self.progressViewer11.progress = Float(value11)
                self.progressViewer12.progress = Float(value12)
        
    // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mostRecentTime()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view ells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RatingTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RatingTableViewCell
        
        // Fetches the appropriate day for the data source laout
        let rating = ratings[indexPath.row]
        
        cell.timeLbl.text = rating.time
        cell.circleControl.rating = rating.circleRating
    
        //Determining the line status and adding a color to go along with it: red- very Slow, slow/fast - white, very fast - green
        if rating.lineRating == 0 {
            cell.infoLbl.text = "5 minutes"
        }
        if rating.lineRating == 1 {
            cell.infoLbl.text = "10 minutes"
        }
        if rating.lineRating == 2 {
            cell.infoLbl.text = "15 minutes"
        }
        if rating.lineRating == 3 {
            cell.infoLbl.text = "20 minutes"
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
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "HH"
            let dateString = dateFormatter.string(from: rating.timeIntervalSinceNow as! Date)
            print(dateString)
            
            // Graph code 
            /*
            if dateString == "11" {
                ratingsAt11.append(rating)
                print(ratingsAt11)
                
                var dividedNumber11 =  [Int]()
                
                for rating in ratingsAt11 {
                        //print(rating.slider)
                        //let divdedNumber = rating.slider / ratingsAt11.count
                    var dividedNumbers = [divdedNumber]
                    dividedNumbers.append(divdedNumber)
                    dividedNumber11.append(divdedNumber)
                    print(dividedNumbers)
                    print(divdedNumber)
                    //dividedNumbers.re
                    print(divdedNumber * ratingsAt11.count)
                    
                    //print([divdedNumber])
                }

                if dateString == "12" {
                    ratingsAt12.append(rating)
                    print(ratingsAt12)
                    
                    }
                if dateString == "13" {
                    ratingsAt1.append(rating)
                    print(ratingsAt1)
                    }

                if dateString == "14" {
                    ratingsAt2.append(rating)
                    print(ratingsAt2)
                    }

                if dateString == "15" {
                    ratingsAt3.append(rating)
                    print(ratingsAt3)
                    }

                if dateString == "16" {
                    ratingsAt4.append(rating)
                    print(ratingsAt4)
                    }
                    
                if dateString == "17" {
                    ratingsAt5.append(rating)
                    print(ratingsAt5)
                    }
                if dateString == "18" {
                    ratingsAt5.append(rating)
                    print(ratingsAt5)
                }
                if dateString == "19" {
                    ratingsAt5.append(rating)
                    print(ratingsAt5)
                } if dateString == "20" {
                    ratingsAt5.append(rating)
                    print(ratingsAt5)
                }
                if dateString == "21" {
                    ratingsAt5.append(rating)
                    print(ratingsAt5)
                }
                if dateString == "22" {
                    ratingsAt5.append(rating)
                    print(ratingsAt5)
                }
                if dateString == "23" {
                    ratingsAt5.append(rating)
                    print(ratingsAt5)
                }
            print(dividedNumber11)
            let sumOfRatingAt11 = dividedNumber11.reduce(0, { x, y in x + y})
            print(sumOfRatingAt11)
            let indexPath1 = IndexPath(row: 0, section: 1)
            let indexPath1 = NSIndexPath(index: 0)
            let rating1At11 = ratingsAt11[indexPath1.row]
            let first = rating1At11.lineRating
            let lineRatings = []
            let value1 = 1.0
            self.progressViewer1.progress = Float(value1)
            }
            print(ratingsAt11)
*/
            UserDefaults.standard.set(true, forKey: "switchState")
            UserDefaults.standard.synchronize()
            Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(LocationDetailViewController.resetPost), userInfo: nil, repeats: false)
            print("timer started")
            
        //This following was orginally how a new rating was added to the array of ratings and then displayed in table.
            /*
            ratings.append(rating)
            tableView.insertRows(at: [newIndexPath], with: .top)
            */
            saveRatings()
        }
        
        mostRecentTime()
        saveRatings()
    }
    
    func resetPost() {
        UserDefaults.standard.set(false, forKey: "switchState")
        UserDefaults.standard.synchronize()
        print("timer stopped")
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
            let address = Location?.address
            let phoneNumber = Location?.phoneNumber
            let displayedAddress = Location?.displayedPhoneNumber
            let displayedPhoneNumber = Location?.displayedAddress
        let llLocation = Location?.llLocation
            let qLocation = Location?.qLocation
        
        // Set the reting to be passed to LocationTableViewController after the unwind segue.
        Location = location(detail1: detail1, detail2: detail2, ratingList: ratingList, locationImagine: locationImage1!, address: address!, phoneNumber: phoneNumber!, displayedAddress: displayedAddress!, displayedPhoneNumber: displayedPhoneNumber!, llLocation: llLocation!, qLocation: qLocation!)
        
        saveRatings()
        mostRecentTime()
        print(ratingList)
        print("sent info back to start")
    }

    private func loadSample() {
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
    
    if seconds < 60 && minutes == 0 && hours == 0 {
        return String("1 minute")
    }
    if seconds > 60 || hours == 0{
        return String(format: "%2d", minutes) + " mins"
    }
    if minutes > 60 {
        return String(format: "%02d", hours) + " hours"
    } else {
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)

    }
    }
    

    private func mostRecentTime() {
        
        if ratings.count >= 1{
            let indexPath1 = NSIndexPath(row: 0, section: 0)
            let cellIdentifier = "RatingTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath1 as IndexPath) as? RatingTableViewCell
            let mostRecentRating = ratings[indexPath1.row]
            let mintuesOfLine = mostRecentRating.lineRating
            let timenow = NSDate()
            let dateFormatter = DateFormatter()
            let PostedDate = mostRecentRating.timeIntervalSinceNow
            let minutes = dateFormatter
            dateFormatter.dateFormat = "mm"
            let intervalSincePost = PostedDate?.timeIntervalSinceNow
            let postedDate = stringFromTimeInterval(interval: intervalSincePost! * -1)
            
            if mostRecentRating.lineRating == 0 {
                let LineMinutesString = "5"
                detail2Lbl.text = postedDate + " ago: " + LineMinutesString + " minutes"
            }
            
            if mostRecentRating.lineRating == 1 {
                let LineMinutesString = "10"
                detail2Lbl.text = postedDate + " ago: " + LineMinutesString + " minutes"
            }
            
            if mostRecentRating.lineRating == 2 {
                let LineMinutesString = "15"
                detail2Lbl.text = postedDate + " ago: " + LineMinutesString + " minutes"
            }
            
            if mostRecentRating.lineRating == 3 {
                let LineMinutesString = "20"
                detail2Lbl.text = postedDate + " ago: " + LineMinutesString + " minutes"
            }
            
        }
    }
    
    private func RefresherRequestForData() {
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
            RefresherRequestForData()
            print("refresherRequest")
        }
    }
    
    /*
    @IBAction func CallButton(_ sender: UIButton) {
        
        var url:NSURL = NSURL(string: "tel://" + (Location?.phoneNumber)!)!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    @IBAction func mapAdress(_ sender: UIButton) {
        
        var address:NSURL = NSURL(string: "http://maps.apple.com/z=21&?ll=" + (Location?.llLocation)! + "&z=21&?q=" + (Location?.qLocation)! + "&z=21")!
        UIApplication.shared.open(address as URL, options: [:], completionHandler: nil)
    }
    */
    
}

    





