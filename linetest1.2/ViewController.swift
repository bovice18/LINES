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

class RatingViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var sliderLbl: UILabel!
    
    @IBOutlet weak var commentsPickerView: UIPickerView!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var circleRating: TriangleRatingControl!
    
    @IBOutlet weak var segementedLineLBL: UILabel!
    
    @IBOutlet weak var segementLineController: UISegmentedControl!
    
    var sliderValue = Int()

    @IBAction func slider(_ sender: UISlider)
    {
        sliderLbl.text = String(Int(sender.value)) + " minutes"
        sliderValue = Int(sender.value)

        let triangle = TriangleRatingControl()
        print("***\(triangle.rating)")
        if triangle.rating == 1 {
            segementLineController.selectedSegmentIndex = 2
            print("***\(triangle.rating)")
        }
    }
    
    let locationManager = CLLocationManager()
    let circleRegion = CLCircularRegion()
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var Rating: rating?
    var center: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227) }
    
    var identifier: String {
        return "San Fran"
    }
    
    let pickerData = ["not moving", "quick","long","slow","worth it", "short", "not worth it", "no line", "no wait", "out of the door"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsPickerView.dataSource = self
        commentsPickerView.delegate = self
        
        view.tintColor = UIColor.lightGray
    
        /*let source1 =
        
        let something = source1?.navigationItem.title
        let source = parent?.navigationItem.title
        
        navigationItem.title = source
        */
        
        if let rating = Rating {
            navigationItem.title = rating.locationName
            print("rating11")
        }
        
        var title = String()
        
        var TitleID = UserDefaults.standard.integer(forKey: "title")
        
        switch TitleID {
        case 1:
            navigationItem.title = "Chipotle"
        case 2:
            navigationItem.title = "Bentley's"
        case 3:
            navigationItem.title = "Cornerstone"
        case 4:
            navigationItem.title = "Terrapin Turf"
        case 5:
            navigationItem.title = "Potbelly"
        default:
            navigationItem.title = "What's the Line Like?"
        }
    
        // if UserDefaults.standard.bool(forKey: "Chipotle Mexican Grill") == true {
        //    navigationItem.title = "Chipotle Mexican Grill"
        //    UserDefaults.standard.set(false, forKey: "Chipotle Mexican Grill")
          //  UserDefaults.standard.synchronize()
      //  }
    
        var region1 = CLCircularRegion(center: center, radius: 1000, identifier: identifier)
 
       
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        textField.delegate = self
        
        timeLbl.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle:
            DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
 
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RatingViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if sliderValue == 0 {
            sliderLbl.text = "20 minutes"
            return sliderValue = 20
        }
    }
 
    override func viewDidAppear(_ animated: Bool) {
        var region1 = CLCircularRegion(center: center, radius: 1000, identifier: identifier)

        if region1.contains((locationManager.location?.coordinate)!) == true {
            
            self.saveButton.isEnabled = !UserDefaults.standard.bool(forKey: "switchState")

            print(locationManager.location?.coordinate as Any)
            print("contains")
            
            if UserDefaults.standard.bool(forKey: "switchState") == true {
                Timer.scheduledTimer(timeInterval: 45, target: self, selector: #selector(RatingViewController.resetPost1), userInfo: nil, repeats: false)
                print("second back up timer complete")
            }
        }
        
        if region1.contains((locationManager.location?.coordinate)!) == false {
            print("does not contain")
            saveButton.isEnabled = false
        }
        
        locationManager.stopUpdatingLocation()
        print("location updating stopped")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //PickerView Data Sources/Delegates
        //MARK: Picker View Data Sources
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
        }
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 200.0
        }
    
        //MARK: Picker View Delegates
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let lineRating = segementLineController.selectedSegmentIndex
        let time = timeLbl.text
        let ratingInt = circleRating.rating
      //  let indexRow = commentsPickerView.selectedRow(inComponent: 1)
      //  let indexset = IndexPath(row: indexRow, section: 0)
        let comments = pickerData[commentsPickerView.selectedRow(inComponent: 0)]
        let timeIntervalSinceNow1 = NSDate()
        let timeNow = timeIntervalSinceNow1
        let locationName = navigationItem.title!
        
        if let destinationView = segue.destination as? LocationDetailViewController {
           let locationName = destinationView.detail1Lbl.text
            if destinationView.detail1Lbl.text == "Chipotle Mexican Grill" {
              //  navigationItem.title = "Chipotle Mexican Grill"
                //let locationIdentifier = 1
                print("id working")
            } else {
                print("id wrong location")
            }
        }
        else {
            print("id not working")
        }

     // print("missed")
    
        Rating = rating(locationName: locationName, time: time!, lineRating: lineRating, circleRating: ratingInt, comments: comments, timeIntervalSinceNow: timeNow)
        
         var request = URLRequest(url: URL(string: "http://ec2-54-202-9-244.us-west-2.compute.amazonaws.com/insert.php")!)
        
         request.httpMethod = "POST"
        
        
        
         let postString = "Location_Name=\(locationName)"+"&Line_Rating=\(lineRating)"+"&Circle_Rating=\(ratingInt)"+"&Comments=\(comments)"
        
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
        
        print(Rating?.timeIntervalSinceNow)
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
    
    @IBAction func segmentedController(_ sender: UISegmentedControl) {
        print(segementLineController.selectedSegmentIndex)
        
        if segementLineController.selectedSegmentIndex == 0 {
           // view.tintColor = #colorLiteral(red: 0.002271278063, green: 0.5700045824, blue: 0, alpha: 1)
           // navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.002271278063, green: 0.5700045824, blue: 0, alpha: 1)
        }
        if segementLineController.selectedSegmentIndex == 1 {
           // view.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
           // navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        if segementLineController.selectedSegmentIndex == 2 {
           // view.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
           // navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        if segementLineController.selectedSegmentIndex == 3 {
          //  view.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            //navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
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
    
    private func disablePost2() {
        if circleRating.rating == 0 {
            saveButton.isEnabled = false
        }
    }
 
    @IBAction func cancel(_ sender: UIBarButtonItem) {
            dismiss(animated: true, completion: nil)
        }


}
