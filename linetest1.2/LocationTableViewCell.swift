//
//  LocationTableViewCell.swift
//  linetest1.2
//
//  Created by david crabtree on 1/27/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var detail1Lbl: UILabel!
    
    @IBOutlet weak var detail2Lbl: UILabel!
    
    @IBOutlet weak var TopView: UIView!
    
    @IBOutlet weak var TimeView: UIView!
    
    @IBOutlet weak var timeSinceLastPostLbl: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var minutesLabel: UILabel!

    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var circleImage: UIImageView!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var LineTimeLbl: UILabel!
    
    @IBOutlet weak var timeStampView: UIView!
    
    @IBOutlet weak var colorBar: UIView!
    
    @IBOutlet weak var BackView: UIView!
 
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorBar.layer.cornerRadius = 4
        
        colorBar.layer.borderWidth = 1
        
        colorBar.layer.borderColor = UIColor.black.cgColor
        
        timeStampView.layer.cornerRadius = 4
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        BackView.layer.cornerRadius = 4
        
        TopView.layer.cornerRadius = 4
       
        whiteView.layer.cornerRadius = 4

        // Configure the view for the selected state
    }

}
