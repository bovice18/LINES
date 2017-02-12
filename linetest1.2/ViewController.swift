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

    @IBOutlet weak var sliderLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var segementedLineLBL: UILabel!
    
    @IBOutlet weak var segementLineController: UISegmentedControl!
    
    var sliderValue = Int()
    
    @IBAction func slider(_ sender: UISlider)
    {
        sliderLbl.text = String(Int(sender.value)) + " minutes"
        sliderValue = Int(sender.value)
    }
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var Rating: rating?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        textField.delegate = self
        
        timeLbl.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle:
            DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
 
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RatingViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let slider = sliderValue
        let comments = textField.text
  
        
        // Set the rating to be passed to ratingtable after the unwind segue.
        Rating = rating(time: time!, lineRating: lineRating, slider: slider, comments: comments!)
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
            segementedLineLBL.text = "very fast"
        }
        if segementLineController.selectedSegmentIndex == 1 {
            segementedLineLBL.text = "fast"
        }
        if segementLineController.selectedSegmentIndex == 2 {
            segementedLineLBL.text = "slow"
        }
        if segementLineController.selectedSegmentIndex == 3 {
            segementedLineLBL.text = "Very slow"
        }
    }



    //MARK: Location Manger function(currently not being used)
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
     
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
    }

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
    }
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
            dismiss(animated: true, completion: nil)
        }


}
