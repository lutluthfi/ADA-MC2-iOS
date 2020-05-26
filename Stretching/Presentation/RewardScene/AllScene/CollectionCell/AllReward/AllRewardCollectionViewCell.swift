//
//  AllRewardCollectionViewCell.swift
//  Stretching
//
//  Created by Arie May Wibowo on 27/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class AllRewardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(
        describing: AllRewardCollectionViewCell.self
    )
    
    static let height = CGFloat(180)

    @IBOutlet weak var imageAllReward: UIImageView!
    @IBOutlet weak var titleAllReward: UILabel!
    @IBOutlet weak var descAllReward: UILabel!
    @IBOutlet weak var buttonTryFilter: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.layer.cornerRadius = 8
        let rewardImageViewCorner = self.imageAllReward.frame.height / 2
        self.imageAllReward.layer.cornerRadius = rewardImageViewCorner
    }
    
    func fill(with title: String, image: UIImage, description: String) {
        self.titleAllReward.text = title
        self.imageAllReward.image = image
        self.descAllReward.text = description
    }

}
