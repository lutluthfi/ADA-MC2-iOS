//
//  PracticeViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 19/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension PracticeViewController {
    class CollectionView {
        static var filterPracticeCollectionViewCellUINib: UINib = {
            return .init(
                nibName: FilterPracticeCollectionViewCell.identifier,
                bundle: nil
            )
        }()
    }
}

class PracticeViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = ScaledCollectionFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 32
        collectionViewLayout.transformScale = 0.5
        collectionViewLayout.isPagingEnabled = true
        collectionViewLayout.minimumAlpha = 0.5
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .lightGray
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CollectionView.filterPracticeCollectionViewCellUINib,
            forCellWithReuseIdentifier: FilterPracticeCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.implementComponentView()
        self.collectionView.scrollToItem(
            at: .init(row: 2, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
}

// MARK: - Implement Component View
extension PracticeViewController {
    private func implementComponentView() {
        defer {
            self.view.layoutIfNeeded()
        }
        
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView
                .heightAnchor
                .constraint(equalToConstant: 150),
            self.collectionView
                .leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor),
            self.collectionView
                .trailingAnchor
                .constraint(equalTo: self.view.trailingAnchor),
            self.collectionView
                .bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UIScrollViewDelegate
extension PracticeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // guard let currentCenterIndex = self.collectionView.currentCenterCellIndex?.row else { return }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension PracticeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = FilterPracticeCollectionViewCell.height
        let width = FilterPracticeCollectionViewCell.height
        return .init(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let identifier = FilterPracticeCollectionViewCell.identifier
        let reusableCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? FilterPracticeCollectionViewCell
        guard let cell = reusableCell else {
            fatalError("Cannot dequeue reusable cell \(identifier) with reuseIdentifier: \(identifier)")
        }
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
}
