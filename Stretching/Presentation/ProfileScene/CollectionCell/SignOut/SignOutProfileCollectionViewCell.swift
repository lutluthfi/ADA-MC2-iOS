//
//  SignOutProfileCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 23/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class SignOutProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = String(
        describing: SignOutProfileCollectionViewCell.self
    )
    static let height = CGFloat(144)

    @IBOutlet weak var signOutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.signOutButton.layer.layoutIfNeeded()
        self.signOutButton.layer.cornerRadius = 8
        self.signOutButton.layer.borderWidth = 1
        self.signOutButton.layer.borderColor = StretchingAssetKit
            .Color
            .colorPrimaryOrange
            .cgColor
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        let height = self.signOutButton.frame.height + 60
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: height)
        layoutAttributes.frame.size = self.contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return layoutAttributes
    }
}
