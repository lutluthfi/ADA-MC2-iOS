//
//  RecommendStretchExploreCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 19/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class RecommendStretchExploreCollectionViewCell: UICollectionViewCell {
    static let identifier = String(
        describing: RecommendStretchExploreCollectionViewCell.self
    )
    static let width = CGFloat()
    static let height = CGFloat()

    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.layer.cornerRadius = 8
    }
    
    func fill(with poster: UIImage) {
        self.posterImageView.image = poster
    }
}
