//
//  InLineViewController.swift
//  linestest1.1
//
//  Created by david crabtree on 1/16/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class InLineViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
   
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    var sliderValue = Int()
    
    @IBAction func slider(_ sender: UISlider) {
        
       sliderLabel.text = String(Int(sender.value)) + " minutes"
    sliderValue = Int(sender.value)
        
    }
    var rating: Rating?
    var comments = String()
    
    @IBOutlet weak var segmentedLineRater: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textField.delegate = self

        // Do any additional setup after loading the view.
       // if let rating = rating {
       //     sliderValue = rating.slider
      //      segmentedLineRater.selectedSegmentIndex = rating.lineRating
     //   }
        
        timeLabel.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle:
            DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InLineViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        if let rating = rating {
            textField.text = rating.comments
            segmentedLineRater.selectedSegmentIndex = rating.lineRating
            sliderValue = rating.slider
            timeLabel.text = rating.time
      
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === (sender as!UIBarButtonItem) {
            let controller = segmentedLineRater.selectedSegmentIndex
            let sliderRating = sliderValue
            let userComments = textField.text ?? ""
            let time = timeLabel.text ?? ""
            
           //intention was to disable save
            /* self.saveButton.isEnabled = false
            Timer.scheduledTimer(timeInterval: 10000, target: self, selector: "enableButton", userInfo: nil, repeats: false)
        */
        
            rating = Rating(slider: sliderRating, lineRating: controller, comments: userComments, time: time)
        print(sliderRating)
        print(controller)
        }
        
       /* func enableSave() {
            self.saveButton.isEnabled = true
        }
        */
    }
    
    @IBAction func segmentedLineRating(_ sender: UISegmentedControl) {
        print(segmentedLineRater.selectedSegmentIndex)
        
        if segmentedLineRater.selectedSegmentIndex == 0 {
            lineLabel.text = "Extremely fast"
        }
        if segmentedLineRater.selectedSegmentIndex == 1 {
            lineLabel.text = "Fast"
        }
        if segmentedLineRater.selectedSegmentIndex == 2 {
            lineLabel.text = "Long"
        }
        if segmentedLineRater.selectedSegmentIndex == 3 {
            lineLabel.text = "Very long"
        }
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    //MARK: Actions
    

}
