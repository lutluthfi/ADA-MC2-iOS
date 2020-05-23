//
//  ProfileViewController.swift
//  Stretching
//
//  Created by Steven Rafaelie on 18/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension ProfileViewController {
    class CollectionView {
        static let accountSection = 0
        static let generalSection = 1
        static let settingSection = 2
        static let signOutSection = 3
        
        static func sections() -> [Int] {
            return [
                self.accountSection,
                self.generalSection,
                self.settingSection,
                self.signOutSection
            ]
        }
        
        static var commonProfileCollectionViewUINib: UINib = {
            return .init(
                nibName: CommonProfileCollectionViewCell.identifier,
                bundle: nil
            )
        }()
        static var headerCommonProfileCollectionViewUINib: UINib = {
            return .init(
                nibName: HeaderCommonProfileCollectionReusableView.identifier,
                bundle: nil
            )
        }()
    }
}

class ProfileViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CollectionView.commonProfileCollectionViewUINib,
            forCellWithReuseIdentifier: CommonProfileCollectionViewCell.identifier
        )
        collectionView.register(
            CollectionView.headerCommonProfileCollectionViewUINib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCommonProfileCollectionReusableView.identifier
        )
        return collectionView
    }()
    
    private let displayedGeneralItems: [String] = [
        "Terms & Conditions",
        "Privacy Policy",
        "Rate Our App"
    ]
    private let displayedSettingItems: [String] = [
        "Notification",
        "Account Privacy"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    private func setupViewDidLoad() {
        self.implementComponentView()
    }
}

extension ProfileViewController {
    private func implementComponentView() {
        defer {
            self.view.layoutIfNeeded()
        }
        
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView
                .leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor),
            self.collectionView
                .topAnchor
                .constraint(equalTo: self.view.topAnchor),
            self.collectionView
                .trailingAnchor
                .constraint(equalTo: self.view.trailingAnchor),
            self.collectionView
                .bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CollectionView.sections().count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case CollectionView.accountSection:
            return 1
        case CollectionView.generalSection:
            return self.displayedGeneralItems.count
        case CollectionView.settingSection:
            return self.displayedSettingItems.count
        case CollectionView.signOutSection:
            return 1
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        switch section {
        case CollectionView.generalSection,
             CollectionView.settingSection:
            let width = collectionView.frame.width - 32
            let height = HeaderCommonProfileCollectionReusableView.height
            return .init(width: width, height: height)
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch indexPath.section {
        case CollectionView.generalSection,
             CollectionView.settingSection:
            let identifier = HeaderCommonProfileCollectionReusableView.identifier
            let reusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? HeaderCommonProfileCollectionReusableView
            guard let view = reusableView else { fatalError() }
            var title = "[Title]"
            switch indexPath.section {
            case CollectionView.generalSection:
                title = "General"
                break
            case CollectionView.settingSection:
                title = "Setting"
                break
            default:
                break
            }
            view.fill(with: title)
            return view
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.section {
        case CollectionView.accountSection:
            return .zero
        case CollectionView.generalSection,
             CollectionView.settingSection:
            let width = collectionView.frame.width - 32
            let height = CommonProfileCollectionViewCell.height
            return .init(width: width, height: height)
        case CollectionView.signOutSection:
            return .zero
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case CollectionView.generalSection, CollectionView.settingSection:
            let identifier = CommonProfileCollectionViewCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? CommonProfileCollectionViewCell
            guard let cell = reusableCell else { fatalError() }
            var item = "[Title]"
            switch indexPath.section {
            case CollectionView.generalSection:
                item = self.displayedGeneralItems[indexPath.row]
                break
            case CollectionView.settingSection:
                item = self.displayedSettingItems[indexPath.row]
                break
            default:
                break
            }
            cell.fill(with: item)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
