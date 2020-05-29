//
//  AllRewardViewController.swift
//  Stretching
//
//  Created by Arie May Wibowo on 27/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension AllRewardViewController {
    class CollectionView {
        static var allRewardCollectionViewUINib: UINib = {
            return .init(
                nibName: AllRewardCollectionViewCell.identifier,
                bundle: nil
            )
        }()
    }
}

class AllRewardViewController: UIViewController {

   @IBOutlet weak var collectionView: UICollectionView!
    
    var allRewardsList: [Reward] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
        processingAllRewardList()
    }

    private func setupViewDidLoad() {
        self.collectionView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            CollectionView.allRewardCollectionViewUINib,
            forCellWithReuseIdentifier: AllRewardCollectionViewCell.identifier
        )
    }
    
    func processingAllRewardList() -> Void {
        for reward in RewardLists().displayedAllRewards {
            if reward.titleAllReward == "Thunder Filter" {
                var tempReward = reward
                tempReward.descAllReward = "You have complete the missions!"
                print(tempReward)
                self.allRewardsList.append(tempReward)
            } else {
                self.allRewardsList.append(reward)
            }
            collectionView.reloadData()
            RewardLists().shownAllRewards.append(contentsOf: self.allRewardsList)
        }
    }
}

extension AllRewardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.allRewardsList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - 32
        let height = AllRewardCollectionViewCell.height
        return .init(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let identifier = AllRewardCollectionViewCell.identifier
        let reusableCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? AllRewardCollectionViewCell
        guard let cell = reusableCell else { fatalError() }
        let reward = self.allRewardsList[indexPath.row]
        if reward.descAllReward == "You have complete the missions!" {
            cell.changeButtonAndDescriptionColor(title: reward.titleAllReward)
        }
        cell.fill(with: reward.titleAllReward, image: reward.imageAllReward, description: reward.descAllReward)
        return cell
    }
}
