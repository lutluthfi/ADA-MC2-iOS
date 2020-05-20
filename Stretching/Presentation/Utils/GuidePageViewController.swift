//
//  ViewController.swift
//  Stretch Guide Page
//
//  Created by Rafika Alifia Isti on 19/05/20.
//  Copyright © 2020 Rafika Alifia Isti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stretchGuide: UIImageView!
    @IBOutlet weak var guideLabel: UILabel!
    var timer = Timer()
    
    let turnMovement =
        [StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide2, StretchingAssetKit.imageGuide3, StretchingAssetKit.imageGuide4, StretchingAssetKit.imageGuide5, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide6, StretchingAssetKit.imageGuide7, StretchingAssetKit.imageGuide8, StretchingAssetKit.imageGuide9, StretchingAssetKit.imageGuide10, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide12, StretchingAssetKit.imageGuide13, StretchingAssetKit.imageGuide14, StretchingAssetKit.imageGuide15, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide16, StretchingAssetKit.imageGuide17, StretchingAssetKit.imageGuide18, StretchingAssetKit.imageGuide19, StretchingAssetKit.imageGuide20]
    
    let tiltMovement = [StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide1, StretchingAssetKit.imageGuide22, StretchingAssetKit.imageGuide23, StretchingAssetKit.imageGuide24, StretchingAssetKit.imageGuide24, StretchingAssetKit.imageGuide24, StretchingAssetKit.imageGuide24, StretchingAssetKit.imageGuide24, StretchingAssetKit.imageGuide24,   StretchingAssetKit.imageGuide25, StretchingAssetKit.imageGuide26, StretchingAssetKit.imageGuide27, StretchingAssetKit.imageGuide28, StretchingAssetKit.imageGuide29, StretchingAssetKit.imageGuide30, StretchingAssetKit.imageGuide31, StretchingAssetKit.imageGuide31, StretchingAssetKit.imageGuide31, StretchingAssetKit.imageGuide31, StretchingAssetKit.imageGuide31, StretchingAssetKit.imageGuide31]


    override func viewDidLoad() {
        super.viewDidLoad()
        turnStretchAnimate()
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(updateMovement), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateMovement() {
        tiltStretchAnimate()
    }
    
    func turnStretchAnimate() {
        let image = turnMovement
        stretchGuide.image = UIImage.animatedImage(with: image, duration: 6)
        guideLabel.text = "Slowly turn to right/left and hold for 8 seconds in each side"
        
    }
    
    func tiltStretchAnimate() {
        stretchGuide.animationImages = tiltMovement
        stretchGuide.animationDuration = 6
        stretchGuide.animationRepeatCount = 1
        stretchGuide.startAnimating()
        guideLabel.text = "Slowly tilt your head to the right/left shoulder and hold for 8 seconds in each side"
    }
    
}

