//
//  DefaultHeaderExploreCollectionReusableView.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 20/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class DefaultHeaderExploreCollectionReusableView: UICollectionReusableView {
    static let identifier = String(
        describing: DefaultHeaderExploreCollectionReusableView.self
    )
    static let height = CGFloat(48)

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    func fill(with title: String) {
        self.titleLabel.text = title
    }
}
