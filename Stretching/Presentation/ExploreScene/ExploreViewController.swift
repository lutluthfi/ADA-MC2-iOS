//
//  ExploreViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 19/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension ExploreViewController {
    class CollectionView {
        enum Section: Int, CaseIterable {
            case greetings = 0
            case recommend = 1
            case type = 2
        }
        
        static let defaultHeaderExploreCollectionReusableViewUINib: UINib = {
            return .init(
                nibName: DefaultHeaderExploreCollectionReusableView.identifier,
                bundle: nil
            )
        }()
        static let greetingsGreetingsExploreCollectionViewCellUINib: UINib = {
            return .init(
                nibName: GreetingsExploreCollectionViewCell.identifier,
                bundle: nil
            )
        }()
        static let recommendStretchExploreCollectionVieCellUINib: UINib = {
            return .init(
                nibName: RecommendStretchExploreCollectionViewCell.identifier,
                bundle: nil
            )
        }()
        static let typeStretchExploreCollectionViewCellUINib: UINib = {
            return .init(
                nibName: TypeStretchExploreCollectionViewCell.identifier,
                bundle: nil
            )
        }()
    }
}

class ExploreViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.createCollectionViewLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CollectionView.defaultHeaderExploreCollectionReusableViewUINib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DefaultHeaderExploreCollectionReusableView.identifier
        )
        collectionView.register(
            CollectionView.greetingsGreetingsExploreCollectionViewCellUINib,
            forCellWithReuseIdentifier: GreetingsExploreCollectionViewCell.identifier
        )
        collectionView.register(
            CollectionView.recommendStretchExploreCollectionVieCellUINib,
            forCellWithReuseIdentifier: RecommendStretchExploreCollectionViewCell.identifier
        )
        collectionView.register(
            CollectionView.typeStretchExploreCollectionViewCellUINib,
            forCellWithReuseIdentifier: TypeStretchExploreCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    private let displayedRecommendStretchPosters: [UIImage] = [
        StretchingAssetKit.Image.imageRecommendInternalRotationStretch,
        StretchingAssetKit.Image.imageRecommendLevatorScapulaeStretch,
        StretchingAssetKit.Image.imageRecommendSideToSideStretch,
        StretchingAssetKit.Image.imageRecommendUpperTraperziuStretch,
    ]
    private let displayedTypeStretchPosters: [UIImage] = [
        StretchingAssetKit.Image.imageTypeStretchNeck,
        StretchingAssetKit.Image.imageTypeStretchShoulder,
        StretchingAssetKit.Image.imageTypeStretchWrist,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.implementComponentView()
    }
    
    private func implementComponentView() {
        defer {
            self.view.layoutIfNeeded()
        }
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView
                .topAnchor
                .constraint(equalTo: self.view.topAnchor),
            self.collectionView
                .leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor),
            self.collectionView
                .trailingAnchor
                .constraint(equalTo: self.view.trailingAnchor),
            self.collectionView
                .bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - Create Compositional Layout
extension ExploreViewController {
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout
        { (section, environtment) -> NSCollectionLayoutSection? in
            let section = CollectionView.Section.allCases[section]
            switch section {
            case .greetings:
                return self.createGreetingsSection()
            case .recommend:
                return self.createRecommendStretchingSection()
            case .type:
                return self.createTypeStretchingSection()
            }
        }
        return layout
    }
    
    private func createGreetingsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let widthDimension = self.view.frame.width
        let heightDimesion = GreetingsExploreCollectionViewCell.height
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(widthDimension),
            heightDimension: .absolute(heightDimesion)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        group.contentInsets = .init(top: .zero, leading: 8, bottom: .zero, trailing: 8) // Spacing for items
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(DefaultHeaderExploreCollectionReusableView.height)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        sectionHeader.contentInsets = .init(
            top: .zero,
            leading: 4,
            bottom: .zero,
            trailing: 4
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        // section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: .zero, leading: 16, bottom: .zero, trailing: 16) // Spacing for sections
        return section
    }
    
    private func createRecommendStretchingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let widthDimension = self.view.frame.width / 2
        let heightDimesion = 3 / 2 * widthDimension
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(widthDimension),
            heightDimension: .absolute(heightDimesion)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        group.contentInsets = .init(top: .zero, leading: 8, bottom: .zero, trailing: 8) // Spacing for items
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(DefaultHeaderExploreCollectionReusableView.height) 
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        sectionHeader.contentInsets = .init(
            top: .zero,
            leading: 4,
            bottom: .zero,
            trailing: 4
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: .zero, leading: 16, bottom: .zero, trailing: 16) // Spacing for sections
        return section
    }
    
    private func createTypeStretchingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let widthDimension = TypeStretchExploreCollectionViewCell.width
        let heightDimension = TypeStretchExploreCollectionViewCell.height
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(widthDimension),
            heightDimension: .absolute(heightDimension)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        group.contentInsets = .init(top: .zero, leading: 8, bottom: 0, trailing: 8)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(DefaultHeaderExploreCollectionReusableView.height)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        sectionHeader.contentInsets = .init(
            top: .zero,
            leading: 4,
            bottom: .zero,
            trailing: 4
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(
            top: .zero,
            leading: 16,
            bottom: .zero,
            trailing: 16
        )
        return section
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CollectionView.Section.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case CollectionView.Section.greetings.rawValue:
            return 1
        case CollectionView.Section.recommend.rawValue:
            return self.displayedRecommendStretchPosters.count
        case CollectionView.Section.type.rawValue:
            return self.displayedTypeStretchPosters.count
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let identifier = DefaultHeaderExploreCollectionReusableView.identifier
            let reusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? DefaultHeaderExploreCollectionReusableView
            guard let view = reusableView else {
                fatalError()
            }
            switch indexPath.section {
            case CollectionView.Section.recommend.rawValue:
                view.fill(with: "Recommended Stretching")
                break
            case CollectionView.Section.type.rawValue:
                view.fill(with: "Stretching Type")
                break
            default:
                break
            }
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case CollectionView.Section.greetings.rawValue:
            let identifier = GreetingsExploreCollectionViewCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? GreetingsExploreCollectionViewCell
            guard let cell = reusableCell else {
                fatalError()
            }
            cell.fill(with: "Fika")
            return cell
        case CollectionView.Section.recommend.rawValue:
            let identifier = RecommendStretchExploreCollectionViewCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? RecommendStretchExploreCollectionViewCell
            guard let cell = reusableCell else {
                fatalError()
            }
            let poster = self.displayedRecommendStretchPosters[indexPath.row]
            cell.fill(with: poster)
            return cell
        case CollectionView.Section.type.rawValue:
            let identifier = TypeStretchExploreCollectionViewCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? TypeStretchExploreCollectionViewCell
            guard let cell = reusableCell else {
                fatalError()
            }
            let poster = self.displayedTypeStretchPosters[indexPath.row]
            cell.fill(with: poster)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
