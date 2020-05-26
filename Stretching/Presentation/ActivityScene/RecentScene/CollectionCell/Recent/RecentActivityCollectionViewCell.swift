//
//  RecentActivityCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 26/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class RecentActivityCollectionViewCell: UICollectionViewCell {
    static let identifier = String(
        describing: RecentActivityCollectionViewCell.self
    )
    static let height = CGFloat(56)

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.layer.cornerRadius = 8
        let posterImageViewCorner = self.posterImageView.frame.height / 2
        self.posterImageView.layer.cornerRadius = posterImageViewCorner
    }

    func fill(with title: String) {
        self.titleLabel.text = title
    }
}
