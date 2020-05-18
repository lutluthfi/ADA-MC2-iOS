//
//  SettingCell.swift
//  Stretching
//
//  Created by Steven Rafaelie on 18/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var labelOutput: UILabel!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
