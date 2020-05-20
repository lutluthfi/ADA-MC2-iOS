//
//  RewardViewCell.swift
//  Stretching
//
//  Created by Steven Rafaelie on 18/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class RewardViewCell: UITableViewCell {

    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var filterName: UILabel!
    @IBOutlet weak var filterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        filterButton.layer.cornerRadius = 10
        filterName.layer.cornerRadius = 5
        filterImage.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
    }
}
