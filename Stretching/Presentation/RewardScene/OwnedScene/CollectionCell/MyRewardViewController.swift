//
//  MyRewardViewController.swift
//  Stretching
//
//  Created by Arie May Wibowo on 27/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension MyRewardViewController {
    class CollectionView {
        static var myRewardCollectionViewUINib: UINib = {
            return .init(
                nibName: MyRewardCollectionViewCell.identifier,
                bundle: nil
            )
        }()
    }
}

class MyRewardViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

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
            forCellWithReuseIdentifier: MyRewardCollectionViewCell.identifier
        )
    }

}

extension MyRewardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return RewardLists().myRewardList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - 32
        let height = MyRewardCollectionViewCell.height
        return .init(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let identifier = MyRewardCollectionViewCell.identifier
        let reusableCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? MyRewardCollectionViewCell
        guard let cell = reusableCell else { fatalError() }
        let reward = RewardLists().myRewardList[indexPath.row]
        cell.fill(with: reward.titleAllReward, image: reward.imageAllReward)
        return cell
    }
}
