//
//  CloudkitViewController.swift
//  linetest1.2
//
//  Created by david crabtree on 1/30/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class CloudkitViewController: LocationDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let rating1 = rating(time: "", lineRating: 2, slider: 23, comments: "short")
        
        ratings += [rating1]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  ratingListTable()
        return ratings.count
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
