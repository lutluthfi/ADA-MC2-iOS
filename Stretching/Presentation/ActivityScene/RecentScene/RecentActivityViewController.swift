//
//  RecentActivityViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 26/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension RecentActivityViewController {
    class CollectionView {
        static var recentActivityCollectionViewUINib: UINib = {
            return .init(
                nibName: RecentActivityCollectionViewCell.identifier,
                bundle: nil
            )
        }()
    }
}

class RecentActivityViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let displayedRecentActivities: [String] = [
        "Side to Side Neck Stretch",
        "Side to Side Neck Stretch",
        "Side to Side Neck Stretch",
        "Side to Side Neck Stretch"
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
            CollectionView.recentActivityCollectionViewUINib,
            forCellWithReuseIdentifier: RecentActivityCollectionViewCell.identifier
        )
    }
}

extension RecentActivityViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.displayedRecentActivities.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - 32
        let height = RecentActivityCollectionViewCell.height
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
        ) as? RecentActivityCollectionViewCell
        guard let cell = reusableCell else { fatalError() }
        let activity = self.displayedRecentActivities[indexPath.row]
        cell.fill(with: activity)
        return cell
    }
}
