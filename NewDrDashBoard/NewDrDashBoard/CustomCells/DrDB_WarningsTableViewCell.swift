//
//  DrDB_WarningsTableViewCell.swift
//  NewDrDashBoard
//
//  Created by MACBookPro on 8/16/16.
//  Copyright © 2016 cognizant. All rights reserved.
//

import UIKit

class DrDB_WarningsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSelect:UIButton!
    @IBOutlet weak var lblParameter:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblValue:UILabel!

    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
