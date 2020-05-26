//
//  MyRewardCollectionViewCell.swift
//  Stretching
//
//  Created by Arie May Wibowo on 27/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class MyRewardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(
        describing: MyRewardCollectionViewCell.self
    )
    
    static let height = CGFloat(180)

    @IBOutlet weak var imageReward: UIImageView!
    @IBOutlet weak var titleReward: UILabel!
    @IBOutlet weak var buttonTryReward: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.layer.cornerRadius = 8
        let rewardImageViewCorner = self.imageReward.frame.height / 2
        self.imageReward.layer.cornerRadius = rewardImageViewCorner
    }

    func fill(with title: String, image: UIImage) {
        self.titleReward.text = title
        self.imageReward.image = image
    }

}
