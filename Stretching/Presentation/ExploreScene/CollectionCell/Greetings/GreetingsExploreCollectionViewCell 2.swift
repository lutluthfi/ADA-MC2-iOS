//
//  GreetingsExploreCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 20/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class GreetingsExploreCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: GreetingsExploreCollectionViewCell.self)
    static let height = CGFloat(135)

    @IBOutlet weak var greetingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    func fill(with name: String) {
        let greetings = self.greetingsLabel
            .text?
            .replacingOccurrences(of: "[Name]", with: name)
        self.greetingsLabel.text = greetings
    }
}
