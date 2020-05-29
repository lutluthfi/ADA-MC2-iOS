//
//  RewardLists.swift
//  Stretching
//
//  Created by Arie May Wibowo on 29/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//
import UIKit

struct Reward {
    var imageAllReward: UIImage
    var titleAllReward: String
    var descAllReward: String
    
    init(image: UIImage, title: String, description: String) {
        self.imageAllReward = image
        self.titleAllReward = title
        self.descAllReward = description
    }
}


class RewardLists {
    
    public let displayedAllRewards: [Reward] = [
        Reward(image: #imageLiteral(resourceName: "thunder copy"), title: "Thunder Filter", description: "Get 5 stars in a nect stretch"),
        Reward(image: #imageLiteral(resourceName: "istockphoto-1134423558-1024x1024"), title: "Pikachu Filter", description: "Get 5 stars in a shoulder stretch")
    ]
    
    var shownAllRewards: [Reward] = []
    
    var myRewardList: [Reward] = []
    
}
