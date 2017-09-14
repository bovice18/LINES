
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
    
    @IBOutlet weak var ActivityView: UIView!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var loadingView: UIView!
    
    
    var locations = [location]()
    
    var location1ratings = [rating]()
    
    var ratings = [rating]()
    
    var ChipotleCircle = Int()
    
    // var ChipotleLine: Int?
    
    var ChipotleTime = String()
    
    var McGarveysCircle = Int()
    
    // var PotBellyLine: Int?
    
    var McGraveysTime = String()
    
    var PussersCircle = Int()
    
    // var CornerstoneLine: Int?
    
    var PussersTime = String()
    
    var AcmeCircle = Int()
    
    //var BentlysLine: Int?
    
    var AcmeTime = String()
    
    var MoesCircle = Int()
    
    // var TerrapinTurfLine = Int()
    
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
    
    var locationList: [location] = [location]()
    
    var locationSearchingList: [location] = [location]()
    
    var AcmeSpecial = [Special]()
    
    var aSpecial = Special(name: "MONDAY", details: "$3 Domestic Bottles - $3 Craft Beers", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial1 = Special(name: "SUNDAY", details: "$10 Select Bottles of Wine - $3 Select Vodka Drinks - $3 Craft Beers", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial2 = Special(name: "TUESDAY", details: "$3 Select Vodka Shots - $3 Domestic Beers ", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial3 = Special(name: "WEDNESDAY", details: "$4 Vodka Drinks (ladies only) - $3 Domestic Bottles", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial4 = Special(name: "THURSDAY", details: "$4 Vodka Drinks (ladies only) - $3 Domestic Bottles", Image: #imageLiteral(resourceName: "acme1"))
  //  var aSpecial5 = Special(name: "Monday Night", details: "Bud Light: $1", Image: #imageLiteral(resourceName: "acme1"))
  //  var aSpecial6 = Special(name: "Monday Night", details: "Bud Light: $1", Image: #imageLiteral(resourceName: "acme1"))
    
    
    
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
            
            
            if let dictionary = json as? [String: Any] {
                
                if let nestedDictionary = dictionary["Acme"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("Restuarant key")
                    
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
                            print("Acme time is here")
                            print(self.AcmeTime)
                        } else {
                            self.AcmeTime = lastupdated
                        }
                       /// self.tableView.reloadData()
                       // self.viewDidAppear(true)
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
                self.sampleLocations()
                DispatchQueue.main.async() { self.tableView.reloadData() }
                //self.endLoading()
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false

                //self.tableView.reloadData()
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
       // self.sampleLocations()
      //  self.tableView.reloadData()
        task.resume()
       // self.sampleLocations()
      //  self.tableView.reloadData()
    }
    
    
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
                    
                    /*   case "Moes":
                     
                     self.MoesCircle = Int(circleRating)!
                     
                     self.MoesTime = TimeSincePost
                     
                     dataPiece?.waitTime = Int(circleRating)!
                     
                     dataPiece?.postTime = dateString
                     
                     self.MoesDataPiece.append(dataPiece!)
                     
                     print(self.MoesDataPiece)
                     
                     print("array")
                     
                     print(self.MoesDataPiece.count)
                     */
                    
                case "Armadillos":
                    
                    self.RedBeanCirle = Int(circleRating)!
                    
                    self.RedBeanTime = TimeSincePost
                    
                    dataPiece?.waitTime = Int(circleRating)!
                    
                    dataPiece?.postTime = dateString
                    
                    self.RedBeanDataPiece.append(dataPiece!)
                    
                    print(self.RedBeanDataPiece)
                    
                    print("array")
                    
                    print(self.RedBeanDataPiece.count)
                    
                    /*
                     
                     case "Annapolis Ice Cream Co":
                     
                     self.AnnapolisIceCircle = Int(circleRating)!
                     
                     self.AnnapolisIceTime = TimeSincePost
                     
                     dataPiece?.waitTime = Int(circleRating)!
                     
                     dataPiece?.postTime = dateString
                     
                     self.AnnapolisIceDataPiece.append(dataPiece!)
                     
                     print(self.AnnapolisIceDataPiece)
                     
                     print("array")
                     
                     print(self.AnnapolisIceDataPiece.count)
                     
                     case "Joss":
                     
                     self.JossCircle = Int(circleRating)!
                     
                     self.JossTime = TimeSincePost
                     
                     dataPiece?.waitTime = Int(circleRating)!
                     
                     dataPiece?.postTime = dateString
                     
                     self.JossDataPiece.append(dataPiece!)
                     
                     print(self.JossDataPiece)
                     
                     print("array")
                     
                     print(self.JossDataPiece.count)
                     
                     case "Iron Rooster":
                     
                     self.IronCircle = Int(circleRating)!
                     
                     self.IronTime = TimeSincePost
                     
                     dataPiece?.waitTime = Int(circleRating)!
                     
                     dataPiece?.postTime = dateString
                     
                     self.IronRoosterDataPiece.append(dataPiece!)
                     
                     print(self.IronRoosterDataPiece)
                     
                     print("array")
                     
                     print(self.IronRoosterDataPiece.count) */
                    
                case "Dock Street":
                    
                    self.DockStreetCircle = Int(circleRating)!
                    
                    self.DockStreetTime = TimeSincePost
                    
                    dataPiece?.waitTime = Int(circleRating)!
                    
                    dataPiece?.postTime = dateString
                    
                    self.DockStreetDataPiece.append(dataPiece!)
                    
                    print(self.DockStreetDataPiece)
                    
                    print("array")
                    
                    print(self.DockStreetDataPiece.count)
                    
                    /*
                     
                     case "City Dock Cafe":
                     
                     self.CityDockCircle = Int(circleRating)!
                     
                     self.CityDockTime = TimeSincePost
                     
                     dataPiece?.waitTime = Int(circleRating)!
                     
                     dataPiece?.postTime = dateString
                     
                     self.CityDockCafeDataPiece.append(dataPiece!)
                     
                     print(self.CityDockCafeDataPiece)
                     
                     print("array")
                     
                     print(self.CityDockCafeDataPiece.count)
                     
                     case "Storm Bros":
                     
                     self.StormBrosCircle = Int(circleRating)!
                     
                     self.StormBrosTime = TimeSincePost
                     
                     dataPiece?.waitTime = Int(circleRating)!
                     
                     dataPiece?.postTime = dateString
                     
                     self.StormBrosDataPiece.append(dataPiece!)
                     
                     print(self.CityDockCafeDataPiece)
                     
                     print("array")
                     
                     print(self.CityDockCafeDataPiece.count)
                     
                     case "Starbucks":
                     
                     self.StarbucksCircle = Int(circleRating)!
                     
                     self.StarbucksTime = TimeSincePost
                     
                     dataPiece?.waitTime = Int(circleRating)!
                     
                     dataPiece?.postTime = dateString
                     
                     self.StarbucksDataPiece.append(dataPiece!)
                     
                     print(self.StarbucksDataPiece)
                     
                     print("array")
                     
                     print(self.StarbucksDataPiece.count)
                     */
                    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        AcmeSpecial = [aSpecial!,aSpecial1!,aSpecial2!,aSpecial3!,aSpecial4!]
        
        //loadData1()
        NewLoadData()
        // tableView.reloadData()
        
        print(chipotleRatings)
        
        let currentDate = NSDate()
        
        print(currentDate)
        
        locationList = locations
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //locations.count
        
        sampleLocations()
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
        
        
        cell.detail1Lbl.text = location.detail1
        
        cell.timeSinceLastPostLbl.text = location.timeSinceLastPost
        
        switch location.llLocation {
            
        case 0:
            
            cell.arrowImage.image = #imageLiteral(resourceName: "0")
            
            cell.minutesLabel.text = "no recent posts"
            
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
        
        UIButton.appearance().setTitleColor(UIColor.green, for: UIControlState.normal)
        
        let postAction = UITableViewRowAction(style: .normal, title: "          ") { (action: UITableViewRowAction!, indexPath: IndexPath!) -> Void in
            
            let firstActivityAction = self.locations[indexPath.row]
            
            var request = URLRequest(url: URL(string: "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/insert.php")!)
            
            request.httpMethod = "POST"
            
            let postString = "Location_Name=\(firstActivityAction.detail2)"+"&Circle_Rating=\(firstActivityAction.llLocation)"
            
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
            
            let selectedLocation = locations[indexPath.row]
            
            locationDetailViewController.Location = selectedLocation
            
            locationDetailViewController.directPost = 0
            
            
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
            
        case "Confirmation":
            
            print("Line Confirmed")
            
        case "Confirmed":
            
            print("line is confirmed")
            
        case "Back":
            print("back was pressed")
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    func loadAcme() {
        
      //  guard let Acme = location(detail1: "Acme Bar & Grill", detail2: "Acme", ratingList: ratings as NSArray, locationImagine: #imageLiteral(resourceName: "home"), timeSinceLastPost: self.AcmeTime, phoneNumber: "3012778898", displayedAddress: "7323 Baltimore Ave, College Park, MD", displayedPhoneNumber: "(301) 277-8898", llLocation: self.AcmeCircle, ratings: AcmeDataPiece) else {
           // fatalError("Unable to instantiate location2")
        //}
        //locations += [Acme]
      //  tableView.reloadData()
    }
    func sampleLocations() {
        
        //currently loads blank arrays into the LocaitonDetailViewController table view when a location is selceted.  Thinking we would say ratingList: name of databased containing the ratings to be entered into the table.  Until we change the the rating list from an empty array every time the app is restarted it will continue to load with no ratings.
        
        // loadData1()
        
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
        
      /*  if let sourceViewController = sender.source as? LoadingViewController, let Location = sourceViewController.location1 {
            locations.append(Location)
        }
        if let sourceViewController = sender.source as? LoadingViewController, let Location = sourceViewController.location2 {
               locations.append(Location)
        }
        if let sourceViewController = sender.source as? LoadingViewController, let Location = sourceViewController.location3 {
               locations.append(Location)
        }
        if let sourceViewController = sender.source as? LoadingViewController, let Location = sourceViewController.location4 {
               locations.append(Location)
        }
        if let sourceViewController = sender.source as? LoadingViewController, let Location = sourceViewController.location5 {
               locations.append(Location)
        }
        if let sourceViewController = sender.source as? LoadingViewController, let Location = sourceViewController.location6 {
               locations.append(Location)
        }
        */
        
        // locations.removeAll()
        
        // viewDidLoad()
        
        NewLoadData()
        
        tableView.reloadData()
        
    }
    
    private func loadAfterunwind() {
        loadData1()
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
        
        // self.ActivityView.removeFromSuperview()
        
        NewLoadData()
        
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
        
   //UserDefaults.standard.set(false, forKey: "Annapolis")
        
   //UserDefaults.standard.synchronize()
        
        
    //UserDefaults.standard.set(1, forKey: "Annapolis")
   // UserDefaults.standard.synchronize()
    }
}
