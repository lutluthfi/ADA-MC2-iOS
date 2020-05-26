//
//  MyRewardViewController.swift
//  Stretching
//
//  Created by Arie May Wibowo on 27/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

struct Rewards {
    var imageReward: UIImage
    var titleReward: String
    
    init(image: UIImage, title: String) {
        self.imageReward = image
        self.titleReward = title
    }
}

extension MyRewardViewController {
    class CollectionView {
        static var myRewardCollectionViewUINib: UINib = {
            return .init(
                nibName: RewardViewCell.identifier,
                bundle: nil
            )
        }()
    }
}

class MyRewardViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let displayedMyRewards: [Rewards] = [
        Rewards(image: #imageLiteral(resourceName: "istockphoto-1134423558-1024x1024"), title: "Lucu"),
        Rewards(image: #imageLiteral(resourceName: "thunder copy"), title: "Parah")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }

    private func setupViewDidLoad() {
        self.collectionView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            CollectionView.myRewardCollectionViewUINib,
            forCellWithReuseIdentifier: RewardViewCell.identifier
        )
    }

}

extension MyRewardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.displayedMyRewards.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - 32
        let height = RewardViewCell.height
        return .init(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let identifier = RecentActivityCollectionViewCell.identifier
        let reusableCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? RewardViewCell
        guard let cell = reusableCell else { fatalError() }
        let reward = self.displayedMyRewards[indexPath.row]
        cell.fill(with: reward.titleReward, image: reward.imageReward)
        return cell
    }
}
