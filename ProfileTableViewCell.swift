//
//  ProfileTableViewCell.swift
//  HeartRateApp
//
//  Created by Amanda Goodhines on 12/15/17.
//  Copyright © 2017 Amanda Goodhines. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sportLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
