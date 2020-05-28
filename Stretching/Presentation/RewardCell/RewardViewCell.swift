//
//  RewardViewCell.swift
//  Stretching
//
//  Created by Steven Rafaelie on 18/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class RewardViewCell: UICollectionViewCell {
    
    static let identifier = String(
        describing: RewardViewCell.self
    )
    
    static let height = CGFloat(180)

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

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func fill(with title: String, image: UIImage) {
        self.filterName.text = title
        self.filterImage.image = image
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
    }
}
