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
    @IBOutlet weak var locationImagine: UIImageView!
    @IBOutlet weak var jointheLineButton: UIButton!
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var circleRating: TriangleRatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        whiteView.layer.cornerRadius = 4

        jointheLineButton.layer.cornerRadius = 4
        jointheLineButton.layer.borderWidth = 1
        jointheLineButton.layer.borderColor = UIColor.blue.cgColor
        // Configure the view for the selected state
    }

}
