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

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageAllReward: UIImageView!
    @IBOutlet weak var titleAllReward: UILabel!
    @IBOutlet weak var descAllReward: UILabel!
    @IBOutlet weak var buttonTryFilter: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.layer.cornerRadius = 8
        self.viewContainer.layer.shadowColor = UIColor.black.cgColor
        self.viewContainer.layer.shadowOpacity = 0.1
        self.viewContainer.layer.shadowOffset = .zero
        self.viewContainer.layer.shadowRadius = 5
        let rewardImageViewCorner = self.imageAllReward.frame.height / 2
        self.imageAllReward.layer.cornerRadius = rewardImageViewCorner
        self.buttonTryFilter.layer.cornerRadius = 15
    }
    
    func fill(with title: String, image: UIImage, description: String) {
        self.titleAllReward.text = title
        self.imageAllReward.image = image
        self.descAllReward.text = description
    }
    
    func changeButtonAndDescriptionColor(title: String) -> Void {
        self.buttonTryFilter.titleLabel?.text = "Unlock"
        self.descAllReward.textColor = UIColor.orange
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        if sender.currentTitle == "Unlock" {
            for item in RewardLists().shownAllRewards {
                if item.descAllReward == "You have complete the missions!" {
                    RewardLists().myRewardList.append(item)
                }
            }
        }
//        if sender.currentTitle == "Unlock" {
//            RewardLists().myRewardList.append(RewardLists().displayedAllRewards[])
//        }
    }
    

}
