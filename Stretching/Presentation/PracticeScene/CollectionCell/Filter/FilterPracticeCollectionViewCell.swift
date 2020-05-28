//
//  FilterPracticeCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 23/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class FilterPracticeCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing:
        FilterPracticeCollectionViewCell.self
    )
    static let height = CGFloat(100)
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        let cellCorner = FilterPracticeCollectionViewCell.height / 2
        self.layer.cornerRadius = cellCorner
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 8
        self.contentView.backgroundColor = .clear
        self.imageView.image = "🤖".emojiImage()
    }

}
