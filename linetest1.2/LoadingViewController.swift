//
//  LoadingViewController.swift
//  LINES
//
//  Created by david crabtree on 7/16/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import os.log

class LoadingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var currentTask: URLSessionDataTask?
    
    var cityImages = [UIImage()]

    //var location = String()
    var locations = [City]()
    var cities = [City]()
    
  //  var locations = ["Annapolis, MD", "College Park, MD"]
    
       override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //    navigationController?.navigationBar.
        //UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        
     //   print("location to start")
       // print(locations)

        
        if let savedCities = loadCities() {
            if savedCities == []
            {
                NewLoadData()
            }
            cities += savedCities
            NewLoadData()
            print("within first if city first then locations")
            print(cities)
            print(locations)
        } else {
            // Load the sample data.
            NewLoadData()
            print("within else. city first then locations")
            print(cities)
            print(locations)
            saveCities()
        }
        
        
        //NewLoadData()
        
        tableview.delegate = self
        
        tableview.dataSource = self
        

        
       // LoadAnnapolisImage()
      //  LoadImage()
        
        print("view did load")

        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableview: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return locations.count
        return cities.count
        
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view ells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "locationSelect"
        
        let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LocationSelectionTableViewCell
        
       // cell.textLabel = "Annapolis"
        
       //  let location = locations[indexPath.row] // use for locations loading, trying cities now
        let city = cities[indexPath.row]
        //let image = cityImages[indexPath.row]
        
      //  cell.locationLabel.text = location.city
        
       // cell.cityLbl.text = location.city
        cell.cityLbl.text = city.city
    
      /*  DispatchQueue.main.async()
            {
        if location != "" {
             let locationName = location.replacingOccurrences(of: " ", with: "_")
           // print("new name is " + number)
            let url = NSURL(string: "http://waitmatehq.com/\(locationName).jpg")
            let data = NSData(contentsOf:  (url as? URL)!)
            let image = UIImage(data: data as! Data)
           // self.cityImages.append(image!)
            cell.cityImage.image = image
         }
         }
 */
    //    cell.cityImage.image = location.image
        
        cell.cityImage.image = city.image
        // Fetches the appropriate day for the data source laout
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        NSLog("You selected cell number: \(indexPath.row)!")
        
       // self.performSegueWithIdentifier("yourIdentifier", sender: self)
        
    //    let name = locations[indexPath.row]
        let name = cities[indexPath.row]
        print("name")
        print(name)
        
        
       // UserDefaults.standard.set(indexPath.row, forKey: "locationSelected")
      //  LoadingViewController.cancelPreviousPerformRequests(withTarget: self, selector: #selector(NewLoadData), object: nil)
//        URLSessionTask.State.canceling
       
        //    let task = URLSessionTask.self
      //  task.cancel(self)
        print(currentTask)
//currentTask?.suspend()
        DispatchQueue.main.async() {  self.currentTask?.cancel()
        }
        UserDefaults.standard.set(name.city, forKey: "CurrentLocation")
        UserDefaults.standard.synchronize()
        
    }

  /*  func LoadAnnapolisImage()
    {
        
        let url = NSURL(string: "http://waitmatehq.com/Annapolis.jpg")
        let data = NSData(contentsOf:  (url as? URL)!)
        let image = UIImage(data: data as! Data)
        cityImages.insert(image!, at: 1)
        tableview.reloadData()
    }
    */
    func NewLoadData() {
        
        print("Loading images")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let scriptURL = "http://waitmatehq.com/testCities.php"
        
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
            
            /*
            if let dictionary = json as? [String] {
                print("here7")
              //  if let nestedDictionary = dictionary["Annapolis"] as? [String: Any] {
                    // access nested dictionary values by key
                    print("anything")
                   // if let recent = nestedDictionary["recent"] as? String {
                        print("recent")
                        //print(recent)
                        
                     //   self.AcmeCircle = Int(recent)!
                  //  }

                //}
            }
 
            if let dictionary = json as? [Any] {
                print("here1.11")
            }
            
            if let dictionary = json as? [String: Any] {
                print("here1")
                print(dictionary)
                if let number = dictionary["Annapolis"] as? String {
                    print(number)
                    print("here1.1")
                    
                    // access individual value in dictionary
                }
            }
                */
            print("here2")
            
            if let cities1 = json as? [Any] {
                
                print("inside array for cities")
                print(cities1)
                DispatchQueue.main.async() {  self.locations.removeAll() }
                
    
                for city in cities1 {
                    
                if let dictionary = city as? [String: Any] {
                    
                    if let number = dictionary["cityName"] as? String {
                        
                  //  if let cityName = dic["cityName"] as? String {
                        let locationName = number.replacingOccurrences(of: " ", with: "_")
                        let url = NSURL(string: "http://waitmatehq.com/img/\(locationName).jpg")
                        let data = NSData(contentsOf:  (url as? URL)!)
                        let image = UIImage(data: data as! Data)
                    
                        let currentCity = City(city: number, image: image!)
                        print(number)
                        
                        DispatchQueue.main.async() { self.locations.append(currentCity!) }
                        //DispatchQueue.main.async() {   self.tableview.reloadData() }
                      DispatchQueue.main.async()
                        {
                        self.locations.sort  { $0.city < $1.city }
                       // self.tableview.reloadData()
                      //  self.cities = self.locations
                      //  self.tableview.reloadData()
                        }
                     //   print(self.cities)
                      //  print(self.locations)
                     //   self.saveCities()
                    // access individual object in array
                }
            }
                }
                print("Locations")
                print(self.locations)
                print(self.cities)
                DispatchQueue.main.async()
                    {
                        if self.cities != self.locations {
                    
                    print("locations: ")
                    print(self.locations)
                    print("cities: ")
                    print(self.cities)
                    self.cities = self.locations
                  
                            self.tableview.reloadData()
                            self.saveCities()
                        }
                }
               /* DispatchQueue.main.async()
                    {
                        self.cityImages.removeAll()
                for location in self.locations {
                    
                    let locationName = location.replacingOccurrences(of: " ", with: "_")
                    // print("new name is " + number)
                    let url = NSURL(string: "http://waitmatehq.com/\(locationName).jpg")
                    let data = NSData(contentsOf:  (url as? URL)!)
                    let image = UIImage(data: data as! Data)
                    self.cityImages.append(image!)
                        }
                }
 */
              
            }
            /*
            if let array = json as? [String] {
                print("locations are a array")
                if let firstObject = array.first {
                    //print(firstObject)
                    // access individual object in array
                }
                
                DispatchQueue.main.async() {  self.locations.removeAll() }
                for object in array {
                    // access all objects in array
                    print(object)
                    DispatchQueue.main.async() { self.locations.append(object) }
                    print(self.locations)
                    DispatchQueue.main.async() {   self.tableview.reloadData() }
                }
            }
            //
 */
              /*
            if let dictionary = json as? [String: Any] {
                //
                if let nestedDictionary = dictionary["Acme"] as? [String: Any] {
                    // access nested dictionary values by key
                    
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
                            
                            print(self.AcmeTime)
                        } else {
                            self.AcmeTime = lastupdated
                        }
                    }
                }
 */
         
                
                // self.sampleLocations()
               // DispatchQueue.main.async() { self.tableView.reloadData() }
                
            DispatchQueue.main.async() {   UIApplication.shared.isNetworkActivityIndicatorVisible = false }
                
        
            
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
        
      
        task.resume()
    
        self.currentTask = task
    }

    /*
    func LoadImage() {
        
       // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let scriptURL = "http://waitmatehq.com/Annapolis.jpg"
        
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
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
            
            print(json)
            /*
             if let dictionary = json as? [String] {
             print("here7")
             //  if let nestedDictionary = dictionary["Annapolis"] as? [String: Any] {
             // access nested dictionary values by key
             print("anything")
             // if let recent = nestedDictionary["recent"] as? String {
             print("recent")
             //print(recent)
             
             //   self.AcmeCircle = Int(recent)!
             //  }
             
             //}
             }
             
             if let dictionary = json as? [Any] {
             print("here1.11")
             }
             
             if let dictionary = json as? [String: Any] {
             print("here1")
             print(dictionary)
             if let number = dictionary["Annapolis"] as? String {
             print(number)
             print("here1.1")
             
             // access individual value in dictionary
             }
             }
             */
            print("here2")
            
            print("trying to get image")
            
            if let cities = json as? [Any] {
                
                print("inside array for cities")
                print(cities)
                DispatchQueue.main.async() {  self.locations.removeAll() }
                
                
                for city in cities {
                    
                    if let dictionary = city as? [String: Any] {
                        
                        if let number = dictionary["cityName"] as? String {
                            
                            //  if let cityName = dic["cityName"] as? String {
                            
                            print(number)
                            DispatchQueue.main.async() { self.locations.append(number) }
                            DispatchQueue.main.async() {   self.tableview.reloadData() }
                            DispatchQueue.main.async()
                                {
                                    self.locations.sort  { $0 < $1 }
                                    self.tableview.reloadData()
                            }
                            // access individual object in array
                        }
                    }
                }
            }
            /*
             if let array = json as? [String] {
             print("locations are a array")
             if let firstObject = array.first {
             //print(firstObject)
             // access individual object in array
             }
             
             DispatchQueue.main.async() {  self.locations.removeAll() }
             for object in array {
             // access all objects in array
             print(object)
             DispatchQueue.main.async() { self.locations.append(object) }
             print(self.locations)
             DispatchQueue.main.async() {   self.tableview.reloadData() }
             }
             }
             //
             */
            /*
             if let dictionary = json as? [String: Any] {
             //
             if let nestedDictionary = dictionary["Acme"] as? [String: Any] {
             // access nested dictionary values by key
             
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
             
             print(self.AcmeTime)
             } else {
             self.AcmeTime = lastupdated
             }
             }
             }
             */
            
            
            // self.sampleLocations()
            // DispatchQueue.main.async() { self.tableView.reloadData() }
            
         //   DispatchQueue.main.async() {   UIApplication.shared.isNetworkActivityIndicatorVisible = false }
            
            
            
            // Convert server json response to NSDictionary
            do {
                   if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                
                // Print out dictionary
                 print(convertedJsonIntoDict)
                
                // Get value by key
                //  let firstNameValue = convertedJsonIntoDict["locationName"] as? String
                //   print(firstNameValue!)
                
                 }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
 */


    private func saveCities() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cities, toFile: City.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)

        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    private func loadCities() -> [City]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: City.ArchiveURL.path) as? [City]
        
    }

}
