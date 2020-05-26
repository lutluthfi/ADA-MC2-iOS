//
//  AccountProfileCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 23/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class AccountProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = String(
        describing: AccountProfileCollectionViewCell.self
    )
    static let height = CGFloat(80)

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        let photoImageViewCorner = self.photoImageView.bounds.height / 2
        self.photoImageView.layer.cornerRadius = photoImageViewCorner
    }

    func fill(with name: String, email: String, photo: UIImage) {
        self.emailLabel.text = email
        self.nameLabel.text = name
        if let firstCharacter = name.first,
            let firstCharaterImage = String(firstCharacter).emojiImage() {
            self.photoImageView.image = firstCharaterImage
        }
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        let height = AccountProfileCollectionViewCell.height
        let width = layoutAttributes.frame.width
        let targetSize = CGSize(width: width, height: height)
        layoutAttributes.frame.size = self.contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return layoutAttributes
    }
}
