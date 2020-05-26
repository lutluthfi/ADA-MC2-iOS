//
//  WeeklyActivityViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 26/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension WeeklyActivityViewController {
    class CollectionView {
        static var weeklyActivityCollectionViewUINib: UINib = {
            return .init(
                nibName: WeeklyActivityCollectionViewCell.identifier,
                bundle: nil
            )
        }()
    }
}

class WeeklyActivityViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let displayedWeeklyActivities: [(duration: String, amount: String)] = [
        ("10 May - 16 May 2020", "15 activities"),
        ("10 May - 16 May 2020", "15 activities"),
        ("10 May - 16 May 2020", "15 activities")
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
            CollectionView.weeklyActivityCollectionViewUINib,
            forCellWithReuseIdentifier: WeeklyActivityCollectionViewCell.identifier
        )
    }

}

extension WeeklyActivityViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.displayedWeeklyActivities.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - 32
        let height = WeeklyActivityCollectionViewCell.height
        return .init(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let identifier = WeeklyActivityCollectionViewCell.identifier
        let reusableCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? WeeklyActivityCollectionViewCell
        guard let cell = reusableCell else { fatalError() }
        let activity = self.displayedWeeklyActivities[indexPath.row]
        cell.fill(with: activity.duration, amount: activity.amount)
        return cell
    }
}

