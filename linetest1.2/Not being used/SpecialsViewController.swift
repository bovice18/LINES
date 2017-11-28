//
//  SpecialsViewController.swift
//  LINES
//
//  Created by david crabtree on 7/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class SpecialsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTitle: UILabel!
    
    var Specials = [Special]()
    var fullSpecialsString = String()
    @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer) {
        
        performSegue(withIdentifier: "SwitchBack", sender: sender)
        
    }
    /*
    var AllDeals = [Special]()
    
    var aSpecial = Special(name: "MONDAY", details: "$3 Domestic Bottles - $3 Craft Beers", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial1 = Special(name: "SUNDAY", details: "$10 Select Bottles of Wine - $3 Select Vodka Drinks - $3 Craft Beers", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial2 = Special(name: "TUESDAY", details: "$3 Select Vodka Shots - $3 Domestic Beers ", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial3 = Special(name: "WEDNESDAY", details: "$4 Vodka Drinks - $3 Domestic Bottles", Image: #imageLiteral(resourceName: "acme1"))
    var aSpecial4 = Special(name: "THURSDAY", details: "$4 Vodka Drinks - $3 Domestic Bottles", Image: #imageLiteral(resourceName: "acme1"))
    
    var bSpecial = Special(name: "FRIDAY - HAPPY HOUR(4-7PM)", details: "20% beer and liquor - $3.25 Bud Light", Image: #imageLiteral(resourceName: "acme1"))
    var bSpecial1 = Special(name: "FRIDAY - AFTER 9PM", details: "$3 Rails - $4 Fireball and Jim Beam - $4.25 Jager and Titos, $5.25 Stolu and Jack Daniels ", Image: #imageLiteral(resourceName: "acme1"))
    
    var tSpecial = Special(name: "TUESDAY", details: "$4 Margaritas - $3 Coronas", Image: #imageLiteral(resourceName: "acme1"))
    var tSpecial2 = Special(name: "WEDNESDAY", details: "$5 Long Islands", Image: #imageLiteral(resourceName: "acme1"))
    var tSpecial1 = Special(name: "SUNDAY", details: "Bottomless Mimosas", Image: #imageLiteral(resourceName: "acme1"))
 */
    
    
    
    @IBAction func SegmentedControlPressed(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("Wait")
            performSegue(withIdentifier: "SwitchBack", sender: sender)
            
        case 1:
            print("specials")
            
        default:
            print("error with segment")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = UserDefaults.standard.value(forKey: "LongNameSelected") as? String
        NewDataLoad2()
      /*  var title = String()
        
        var TitleID = UserDefaults.standard.integer(forKey: "title")
        
        switch TitleID {
            
        case 1:
            
            navigationItem.title = "Dock Street Bar & Grill"
            
            
        case 2:
            
            navigationItem.title = "Acme Bar & Grill"
            
        case 3:
            
            navigationItem.title = "Pusser's Caribbean Grille"
            
            
        case 4:
            
            navigationItem.title = "Armadillos Restaurant"
            
        case 5:
            
            navigationItem.title = "McGarveys"
            
        case 6:
            
            navigationItem.title = "The Federal House"
            
        case 7:
            
            navigationItem.title = "RJ Bentley's Restaurant"
            
        case 8:
            
            navigationItem.title = "Cornerstone Grill & Loft"
            
        case 9:
            
            navigationItem.title = "Terrapin's Turf"
            

            
        default:
            
            navigationItem.title = "What's the Line Like?"
        }
        
        if  navigationItem.title! == "Acme Bar & Grill" {
            AllDeals  = [aSpecial!, aSpecial1!, aSpecial2!, aSpecial3!, aSpecial4!]
            tableView.reloadData()
        }

        if  navigationItem.title! == "RJ Bentley's Restaurant" {
            AllDeals  = [bSpecial!, bSpecial1!]
            tableView.reloadData()
        }
      if  navigationItem.title! == "Terrapin's Turf" {
        
            AllDeals  = [tSpecial!,tSpecial2!, tSpecial1!]
            tableViewTitle.text = "Happy Hour Specials"
            tableView.reloadData()
        }
       // if navigationItem.title! != "Acme Bar & Grill" || navigationItem.title! != "RJ Bentley's Restaurant"  
    if navigationItem.title! != "Acme Bar & Grill" && navigationItem.title! != "RJ Bentley's Restaurant" && navigationItem.title! != "Terrapin's Turf" {
            AllDeals  = []
            AllDeals.removeAll()
            tableView.reloadData()
            
            tableViewTitle.text = "No Available Specials"
        }
        
        //  AllDeals += [aSpecial!, aSpecial1!, aSpecial2!, aSpecial3!, aSpecial4!]
 */
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
      /*  if (navigationController?.title! == "Acme Bar & Grill") {
            // return AllDeals.count
          //  return AllDeals.count
        } else {
            return AllDeals.count
        }
 */
        return Specials.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RatingTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RatingTableViewCell
        
        // Fetches the appropriate day for the data source laout
        let special = Specials[indexPath.row]
        
        cell.detailsLabel.text = special.details
        
       // cell.LineImage.image = rating.Image
        
        cell.timeLbl.text = special.name

        return cell
 
    }
    
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
