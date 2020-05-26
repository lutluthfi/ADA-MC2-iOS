//
//  AllRewardViewController.swift
//  Stretching
//
//  Created by Arie May Wibowo on 27/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

struct AllReward {
    var imageAllReward: UIImage
    var titleAllReward: String
    var descAllReward: String
    
    init(image: UIImage, title: String, description: String) {
        self.imageAllReward = image
        self.titleAllReward = title
        self.descAllReward = description
    }
}

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
    
    private let displayedAllRewards: [AllReward] = [
        AllReward(image: #imageLiteral(resourceName: "thunder copy"), title: "Stargaze", description: "I don't know actually"),
        AllReward(image: #imageLiteral(resourceName: "istockphoto-1134423558-1024x1024"), title: "Supermie", description: "I am really hungry")
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
            CollectionView.allRewardCollectionViewUINib,
            forCellWithReuseIdentifier: AllRewardCollectionViewCell.identifier
        )
    }
}

extension AllRewardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.displayedAllRewards.count
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
        let reward = self.displayedAllRewards[indexPath.row]
        cell.fill(with: reward.titleAllReward, image: reward.imageAllReward, description: reward.descAllReward)
        return cell
    }
}
