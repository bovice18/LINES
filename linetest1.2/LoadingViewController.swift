//
//  LoadingViewController.swift
//  LINES
//
//  Created by david crabtree on 7/16/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var locations = ["Annapolis, MD", "College Park, MD"]
    
       override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        
        tableview.dataSource = self
        
        
        print("view did load")

        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
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
        return locations.count
        
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view ells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "locationSelect"
        
        let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LocationSelectionTableViewCell
        
       // cell.textLabel = "Annapolis"
        
        let location = locations[indexPath.row]
        
        cell.locationLabel.text = location
        
        
        
        // Fetches the appropriate day for the data source laout

        
       return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        NSLog("You selected cell number: \(indexPath.row)!")
        
       // self.performSegueWithIdentifier("yourIdentifier", sender: self)
        
        UserDefaults.standard.set(indexPath.row, forKey: "locationSelected")
        UserDefaults.standard.synchronize()
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)

        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
