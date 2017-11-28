//
//  SpecialsTableViewCell.swift
//  LINES
//
//  Created by david crabtree on 11/8/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit

class SpecialsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var specialDetailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
