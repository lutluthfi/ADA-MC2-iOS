//
//  String+Extension.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 23/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func emojiImage() -> UIImage? {
        let size = CGSize(width: 42, height: 42)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(
            in: rect,
            withAttributes: [.font: UIFont.systemFont(ofSize: 40)]
        )
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
