//
//  ConfirmationViewController.swift
//  LINES
//
//  Created by david crabtree on 7/14/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        progressView.setProgress(0.0, animated: true)
        
        UIView.animate(withDuration: 2,animations: { () -> Void in self.progressView.setProgress(1.0, animated: true)
        } )
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
