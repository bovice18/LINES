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
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
      //  UserDefaults.standard.set(1, forKey: "annapolis")
       // UserDefaults.standard.synchronize()
        
      //  var id = UserDefaults.standard.object(forKey: "annapolis") as! Int
        
      //  var TitleID = UserDefaults.standard.integer(forKey: "annapolis")
        
   //   switch id {
       // case 1:
          // performSegue(withIdentifier: "Skip", sender: viewDidLoad())
       // print("segue")
       // default:
        //   print("not selected yet")
      // }
        
      //  performSegue(withIdentifier: "Skip", sender: viewDidLoad())
        
     //   SkippingLocation()
        
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
        return 1
        
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view ells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "locationSelect"
        
        let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UITableViewCell
        
       // cell.textLabel = "Annapolis"
        
        
        
        // Fetches the appropriate day for the data source laout

        
       return cell
    }
    
    func SkippingLocation() {
        
        //UserDefaults.standard.integer(forKey: "Ann")
        
     //   UserDefaults.standard
        UserDefaults.standard.set(1, forKey: "annapolis")
        UserDefaults.standard.synchronize()
        
    var TitleID = UserDefaults.standard.integer(forKey: "Annapolis")
        
        switch TitleID {
        case 1:
            performSegue(withIdentifier: "Skip", sender: viewDidLoad())
        default:
            print("not selected yet")
        }

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)

        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
