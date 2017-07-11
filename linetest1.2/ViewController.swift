//
//  ViewController.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import CoreLocation
import os.log

class RatingViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var darkBlueView: UIView!
    
    var LineLength: Int?

    @IBOutlet weak var longSaveButton: UIButton!
    
    @IBOutlet weak var sliderLbl: UILabel!
    
    @IBOutlet weak var commentsPickerView: UIPickerView!
    
    @IBOutlet weak var ArrowImage: UIImageView!

    @IBOutlet weak var timeButton3: UIButton!
    
    @IBOutlet weak var timeButton4: UIButton!
    
    @IBOutlet weak var timeButton2: UIButton!
    
    @IBOutlet weak var timeButton1: UIButton!
    
    @IBOutlet weak var lineRating4Lbl: UILabel!
    
    @IBOutlet weak var lineRating3Lbl: UILabel!
    
    @IBOutlet weak var lineRating1Lbl: UILabel!
    
    @IBOutlet weak var lineRatingLbl2: UILabel!
    
    @IBOutlet weak var lineRating4: UIView!
    
    @IBOutlet weak var lineRating3: UIView!
    
    @IBOutlet weak var lineRating2: UIView!
    
    @IBOutlet weak var lineRating1: UIView!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var segementedLineLBL: UILabel!
    
    @IBOutlet weak var segementLineController: UISegmentedControl!
    
    var sliderValue = Int()
    
    var LocationName: String?
    
    @IBAction func timeButton1Pressed(_ sender: Any) {
        
        self.navigationItem.title = "Extremely Quick"
        
        timeButton1.backgroundColor = UIColor.clear
        
        timeButton2.backgroundColor = UIColor.clear
        
        timeButton3.backgroundColor = UIColor.clear
        
        timeButton4.backgroundColor = UIColor.clear
        
        timeButton1.isEnabled = true
        
        timeButton2.isHighlighted = true
        
        timeButton3.isHighlighted = true
        
        timeButton4.isHighlighted = true

        LineLength = 1
        
        ArrowImage.image = UIImage(named: "0-5")
        
        saveButton.isEnabled = true
        
        longSaveButton.isEnabled = true
        
    }
    
    @IBAction func timeButton2Pressed(_ sender: Any) {
        
        timeButton1.backgroundColor = UIColor.clear
        
        timeButton2.backgroundColor = UIColor.clear
        
        timeButton3.backgroundColor = UIColor.clear
        
        timeButton4.backgroundColor = UIColor.clear
      
        timeButton1.isHighlighted = true
        
        timeButton2.isEnabled = true
        
        timeButton3.isHighlighted = true
        
        timeButton4.isHighlighted = true

        ArrowImage.image = UIImage(named: "5-10")
        
        LineLength = 2
        
        saveButton.isEnabled = true
        
        longSaveButton.isEnabled = true
        
        self.navigationItem.title = "Fast"
      
    }
    
    @IBAction func timeButton3Pressed(_ sender: Any) {
      
        self.navigationItem.title = "Slow"
       
        timeButton1.isHighlighted = true
        
        timeButton2.isHighlighted = true
        
        timeButton3.isEnabled = true
        
        timeButton4.isHighlighted = true

        timeButton1.tintColor = UIColor.black
        
        timeButton1.backgroundColor = UIColor.clear
        
        timeButton2.backgroundColor = UIColor.clear
        
        timeButton3.backgroundColor = UIColor.clear
        
        timeButton4.backgroundColor = UIColor.clear
        
        ArrowImage.image = UIImage(named: "10-20")
           LineLength = 3
        
        saveButton.isEnabled = true
        
        longSaveButton.isEnabled = true
        
    }
    
    @IBAction func timeButton4Pressed(_ sender: Any) {
        
         self.navigationItem.title = "Barely Moving"
        
        timeButton1.backgroundColor = UIColor.clear
        
        timeButton2.backgroundColor = UIColor.clear
        
        timeButton3.backgroundColor = UIColor.clear
        
        timeButton4.backgroundColor = UIColor.clear
        
        timeButton1.isHighlighted = true
        
        timeButton2.isHighlighted = true
        
        timeButton3.isHighlighted = true
        
        timeButton4.isEnabled = true
    
        ArrowImage.image = UIImage(named: "20+")
        
        LineLength = 4
        
        saveButton.isEnabled = true
        
        longSaveButton.isEnabled = true
        
    }

    let locationManager = CLLocationManager()
    
    let circleRegion = CLCircularRegion()
    

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var Rating: rating?
    
    var center: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227) }
    
    var identifier: String {
        return "San Fran"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
    
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = darkBlueView.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        darkBlueView.addSubview(blurEffectView)
        
        darkBlueView.sendSubview(toBack: blurEffectView)
 
        timeButton1.titleLabel?.textColor = UIColor.black
        
        timeButton1.setTitleColor(.black, for: .normal)
        
        timeButton2.setTitleColor(.black, for: .normal)
        
        timeButton3.setTitleColor(.black, for: .normal)
        
        timeButton4.setTitleColor(.black, for: .normal)
        
        timeButton1.layer.borderWidth = 1
        
        timeButton1.layer.borderColor = UIColor.black.cgColor
        
        timeButton1.layer.cornerRadius = 4
        
        timeButton2.layer.borderWidth = 1
        
        timeButton2.layer.borderColor = UIColor.black.cgColor
        
        timeButton2.layer.cornerRadius = 4
        
        timeButton3.layer.cornerRadius = 4
        
        timeButton3.layer.borderWidth = 1
        
        timeButton3.layer.borderColor = UIColor.black.cgColor
        
        timeButton4.layer.cornerRadius = 4
        
        timeButton4.layer.borderWidth = 1
        
        timeButton4.layer.borderColor = UIColor.black.cgColor
        
        lineRating2.layer.cornerRadius = 4
        
        lineRating2.layer.borderWidth = 1
        
        lineRating2.layer.borderColor = UIColor.black.cgColor
        
        lineRating3.layer.cornerRadius = 4
        
        lineRating3.layer.borderWidth = 1
        
        lineRating3.layer.borderColor = UIColor.black.cgColor
        
        lineRating4.layer.cornerRadius = 4
        
        lineRating4.layer.borderWidth = 1
        
        lineRating4.layer.borderColor = UIColor.black.cgColor
        
        self.lineRating1.backgroundColor = UIColor.clear
        
        self.lineRating2.backgroundColor = UIColor.clear
        
        self.lineRating3.backgroundColor = UIColor.clear
        
        self.lineRating4.backgroundColor = UIColor.clear
            
        saveButton.isEnabled = false
        
        longSaveButton.isEnabled = false
        
        longSaveButton.layer.cornerRadius = 4
        
        longSaveButton.layer.shadowOpacity = 0.2
        
        darkBlueView.layer.cornerRadius = 4
        
        darkBlueView.layer.shadowOpacity = 0.2
        
    if let rating = Rating {
        
        navigationItem.title = rating.locationName
        
        print("rating11")
        
        }
        
        var title = String()
        
        var TitleID = UserDefaults.standard.integer(forKey: "title")
        
    switch TitleID {
        
        case 1:
            
            navigationItem.title = "Dock Street"
            
            LocationName = "Dock Street"
        
        case 2:
            
            navigationItem.title = "Acme"
            
            LocationName = "Acme"
        
        case 3:
            
            navigationItem.title = "Pusser's"
            
            LocationName = "Pussers"
        
        case 4:
            
            navigationItem.title = "Armadillos"
            
            LocationName = "Armadillos"
        
        case 5:
            
            navigationItem.title = "McGarveys"
            
            LocationName = "McGarveys"
        
        case 6:
            
            navigationItem.title = "Federal House"
            
            LocationName = "Federal House"
            
        default:
            
            navigationItem.title = "What's the Line Like?"
        }
    
        var region1 = CLCircularRegion(center: center, radius: 1000, identifier: identifier)
 
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        timeLbl.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle:
            DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
 
    }
 
    override func viewDidAppear(_ animated: Bool) {
        var region1 = CLCircularRegion(center: center, radius: 1000, identifier: identifier)

            print(locationManager.location?.coordinate as Any)
            print("contains")
            
            if UserDefaults.standard.bool(forKey: "switchState") == true {
                
                Timer.scheduledTimer(timeInterval: 45, target: self, selector: #selector(RatingViewController.resetPost1), userInfo: nil, repeats: false)
                
                print("second back up timer complete")
            }
        
    locationManager.stopUpdatingLocation()
        
        print("location updating stopped")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetPost1() {
        
        UserDefaults.standard.set(false, forKey: "switchState")
        
        UserDefaults.standard.synchronize()
        
        print("timer stopped")
    }
    
    func changeBackGround() {
        view.backgroundColor = UIColor.red
    }
   
    //MARK: Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)

        var tagPressed: Int
        
        // Configure the destination view controller only when the save button is pressed.
        if let button = sender as? UIBarButtonItem, button === saveButton {
            let time = timeLbl.text
            let ratingInt = LineLength!
          
            let timeIntervalSinceNow1 = NSDate()
            let timeNow = timeIntervalSinceNow1
            let locationName = LocationName!
            
            if let destinationView = segue.destination as? LocationDetailViewController {
                print("id working")
                // } else {
                print("id wrong location")
                //  }
            }
            else {
                print("id not working")
            }
            
            // print("missed")
            
            Rating = rating(locationName: locationName, time: time!, circleRating: ratingInt, timeIntervalSinceNow: timeNow)
            
            var request = URLRequest(url: URL(string: "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/insert.php")!)
            
            request.httpMethod = "POST"
            
            locationName.replacingOccurrences(of: " ", with: "_")
            
            let postString = "Location_Name=\(locationName)"+"&Circle_Rating=\(ratingInt)"
            
            request.httpBody = postString.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
            }
            task.resume()
            
            
            // print(Rating?.locationName as Any)
            //  print(Rating)
            // print("missed")
            
            print(Rating?.timeIntervalSinceNow as Any)
        }
        
        if let button1 = sender as? UIButton, button1 === longSaveButton {
        
        print("first try failed")
        
        
        // guard let button1 = sender as? UIButton, button1 === longSaveButton else {
           // os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
        //    return print("failed 2 try")
        //}
        
        print("all tries passed")
    
        let lineRating = segementLineController.selectedSegmentIndex
        let time = timeLbl.text
        let ratingInt = LineLength!
      //  let indexRow = commentsPickerView.selectedRow(inComponent: 1)
      //  let indexset = IndexPath(row: indexRow, section: 0)
     //   let comments = pickerData[commentsPickerView.selectedRow(inComponent: 0)]
        let timeIntervalSinceNow1 = NSDate()
        let timeNow = timeIntervalSinceNow1
        let locationName = LocationName!
        
        if segue.destination is LocationDetailViewController {
          // let locationName = destinationView.detail1Lbl.text
          //  if destinationView.detail1Lbl.text == "Chipotle Mexican Grill" {
              //  navigationItem.title = "Chipotle Mexican Grill"
                //let locationIdentifier = 1
                print("id working")
           // } else {
                print("id wrong location")
          //  }
        }
        else {
            print("id not working")
        }

     // print("missed")
    
        Rating = rating(locationName: locationName, time: time!, circleRating: ratingInt, timeIntervalSinceNow: timeNow)
        
         var request = URLRequest(url: URL(string: "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/insert.php")!)
        
         request.httpMethod = "POST"
        
        locationName.replacingOccurrences(of: " ", with: "_")
        
         let postString = "Location_Name=\(locationName)"+"&Circle_Rating=\(ratingInt)"
        
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
 
       // self.performSegue(withIdentifier: "Confirmation1", sender: longSaveButton)
       // print(Rating?.locationName as Any)
      //  print(Rating)
       // print("missed")
        
        print(Rating?.timeIntervalSinceNow as Any)
    }
        else {
            print("all tries failed")
        }
    }
    
    // Mark: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed")
    }
    
    func contains(_ coordinate: CLLocationCoordinate2D) -> Bool {
        print("anything")
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let Userslocation = locations.last
        
        var center: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227) }
        
        var identifier: String {
            
            return "San Fran"
        }
        var region1 = CLCircularRegion(center: center, radius: 1000, identifier: identifier)
        
        print("location found")
    }

 
    @IBAction func cancel(_ sender: UIBarButtonItem) {
            dismiss(animated: true, completion: nil)
        }

        
    }
    
    
    

        



