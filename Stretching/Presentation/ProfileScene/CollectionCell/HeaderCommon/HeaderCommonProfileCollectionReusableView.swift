//
//  HeaderCommonProfileCollectionReusableView.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 23/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class HeaderCommonProfileCollectionReusableView: UICollectionReusableView {
    static let identifier = String(describing:
        HeaderCommonProfileCollectionReusableView.self
    )
    static let height = CGFloat(64)
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    func fill(with title: String) {
        self.titleLabel.text = title
    }
}
