//
//  CommonProfileCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 23/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class CommonProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing:
        CommonProfileCollectionViewCell.self
    )
    static let height = CGFloat(56)

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.layer.cornerRadius = 8
    }

    func fill(with title: String) {
        self.titleLabel.text = title
    }
}
