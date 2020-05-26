//
//  WeeklyActivityCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 26/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class WeeklyActivityCollectionViewCell: UICollectionViewCell {
    static let identifier = String(
        describing: WeeklyActivityCollectionViewCell.self
    )
    static let height = CGFloat(56)

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.layoutIfNeeded()
    }

    func fill(with duration: String, amount: String) {
        self.amountLabel.text = amount
        self.durationLabel.text = duration
    }
}
