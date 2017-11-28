//
//  LocationSelectionTableViewCell.swift
//  LINES
//
//  Created by david crabtree on 8/10/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class LocationSelectionTableViewCell: UITableViewCell {
    

    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var barCountLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
