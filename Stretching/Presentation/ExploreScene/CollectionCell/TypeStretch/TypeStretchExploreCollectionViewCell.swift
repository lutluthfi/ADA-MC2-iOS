//
//  TypeStretchExploreCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 19/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class TypeStretchExploreCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing:
        TypeStretchExploreCollectionViewCell.self
    )
    static let height = CGFloat(115)
    static let width = CGFloat(144)

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.posterImageView.layer.cornerRadius = 8
    }

    func fill(with poster: UIImage, title: String) {
        self.posterImageView.image = poster
        self.titleLabel.text = title
    }
}
