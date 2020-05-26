//
//  RewardViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 26/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension RewardViewController {
    class TabBar {
        static let myRewardIndex = 0
        static let allRewardIndex = 1
    }
}

class RewardViewController: UIViewController {
    
    @IBOutlet weak var topBar: UITabBar!
    @IBOutlet weak var myRewardsView: UIView!
    @IBOutlet weak var allRewardsView: UIView!
    
//    var namaFilter = ["Thunder Filter", "Love Love Filter", "Cowboy heart Filter"]
//    var fotoFilter = [ #imageLiteral(resourceName: "thunder copy"), #imageLiteral(resourceName: "istockphoto-1134423558-1024x1024"), #imageLiteral(resourceName: "istockphoto-1134423558-1024x1024")]
    
    
    lazy var myRewardTabBarItem: UITabBarItem = {
        return UITabBarItem(title: "My Reward", image: nil, selectedImage: nil)
    }()
    lazy var allRewardTabBarItem: UITabBarItem = {
        return UITabBarItem(title: "All Reward", image: nil, selectedImage: nil)
    }()
    
    private var currentTabBarIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.title = "Rewards"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViewDidLoad() {
        let loremStringHeight = "Lorem"
            .size(withAttributes: [ .font : UIFont(name: "Montserrat-Medium", size: 16)! ])
            .height
        let modifiedTitlePositioncOffset = UIOffset(
            horizontal: 0,
            vertical: ((self.topBar.frame.height / 2) - (loremStringHeight / 2)) * -1
        )
        self.myRewardTabBarItem.titlePositionAdjustment = modifiedTitlePositioncOffset
        self.allRewardTabBarItem.titlePositionAdjustment = modifiedTitlePositioncOffset
        let topTabBarItems = [
            self.myRewardTabBarItem,
            self.allRewardTabBarItem
        ]
        self.topBar.delegate = self
        self.topBar.items = topTabBarItems
        self.topBar.backgroundColor = .white
        self.topBar.backgroundImage = UIImage()
        self.topBar.shadowImage = UIImage()
        let attrs = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Medium", size: 16)!,
            NSAttributedString.Key.foregroundColor : StretchingAssetKit.Color.colorPrimaryOrangeDark
        ]
        self.myRewardTabBarItem.setTitleTextAttributes(attrs, for: .normal)
        self.allRewardTabBarItem.setTitleTextAttributes(attrs, for: .normal)
        self.topBar.selectedItem = self.myRewardTabBarItem
        let topTabBarFrameSize = self.topBar.frame.size
        let topTabBarItemWidth = topTabBarFrameSize.width / CGFloat(topTabBarItems.count)
        let tabBarSize = CGSize(
            width: topTabBarFrameSize.width / CGFloat(topTabBarItems.count),
            height: self.topBar.frame.height
        )
        let selectionIndicatorRect = CGRect(
            x: (topTabBarItemWidth / 2) - ((topTabBarItemWidth * 0.65) / 2),
            y: tabBarSize.height - 2,
            width: topTabBarItemWidth * 0.65,
            height: 2
        )
        let selectionIndicatorImage = self.view.selectionIndicatorTabBarImage(
            color: StretchingAssetKit.Color.colorPrimaryOrangeDark,
            tabBarSize: tabBarSize,
            selectionIndicatorRect: selectionIndicatorRect
        )
        self.topBar.selectionIndicatorImage = selectionIndicatorImage
    }
    
}

// MARK: - UITabBarDelegate
extension RewardViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        self.currentTabBarIndex = index
        switch index {
        case TabBar.myRewardIndex:
            self.myRewardsView.isHidden = false
            self.allRewardsView.isHidden = true
            break
        case TabBar.allRewardIndex:
            self.myRewardsView.isHidden = true
            self.allRewardsView.isHidden = false
            break
        default:
            break
        }
    }
}

extension UIView {
    fileprivate func selectionIndicatorTabBarImage(
        color: UIColor,
        tabBarSize: CGSize,
        selectionIndicatorRect: CGRect
    ) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: tabBarSize.width, height: tabBarSize.height)
        UIGraphicsBeginImageContextWithOptions(tabBarSize, false, 0)
        UIColor.clear.setFill()
        UIRectFill(rect)
        color.setFill()
        UIRectFill(selectionIndicatorRect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
