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
    
    @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer) {
        
        performSegue(withIdentifier: "SwitchBack", sender: sender)
        
    }
    
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
        var title = String()
        
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
        
        if (navigationController?.title! == "Acme Bar & Grill") {
            // return AllDeals.count
            return AllDeals.count
        } else {
            return AllDeals.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RatingTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RatingTableViewCell
        
        // Fetches the appropriate day for the data source laout
        let rating = AllDeals[indexPath.row]
        
        cell.detailsLabel.text = rating.details
        
        cell.LineImage.image = rating.Image
        
        cell.timeLbl.text = rating.name
        
        return cell
        
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
