//
//  ActivityViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 26/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

extension ActivityViewController {
    class TabBar {
        static let recentIndex = 0
        static let weeklyIndex = 1
    }
}

class ActivityViewController: UIViewController {

    @IBOutlet weak var recentActivityViewControllerContainerView: UIView!
    @IBOutlet weak var topTabBar: UITabBar!
    @IBOutlet weak var weeklyActivityViewControllerContainerView: UIView!

    lazy var recentTabBarItem: UITabBarItem = {
        return UITabBarItem(title: "Recent", image: nil, selectedImage: nil)
    }()
    lazy var weeklyTabBarItem: UITabBarItem = {
        return UITabBarItem(title: "Weekly", image: nil, selectedImage: nil)
    }()
    
    private var currentTabBarIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.title = "Activity"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViewDidLoad() {
        let loremStringHeight = "Lorem"
            .size(withAttributes: [ .font : UIFont(name: "Montserrat-Medium", size: 16)! ])
            .height
        let modifiedTitlePositioncOffset = UIOffset(
            horizontal: 0,
            vertical: ((self.topTabBar.frame.height / 2) - (loremStringHeight / 2)) * -1
        )
        self.recentTabBarItem.titlePositionAdjustment = modifiedTitlePositioncOffset
        self.weeklyTabBarItem.titlePositionAdjustment = modifiedTitlePositioncOffset
        let topTabBarItems = [
            self.recentTabBarItem,
            self.weeklyTabBarItem
        ]
        self.topTabBar.delegate = self
        self.topTabBar.items = topTabBarItems
        self.topTabBar.backgroundColor = .white
        self.topTabBar.backgroundImage = UIImage()
        self.topTabBar.shadowImage = UIImage()
        let attrs = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Medium", size: 16)!,
            NSAttributedString.Key.foregroundColor : StretchingAssetKit.Color.colorPrimaryOrangeDark
        ]
        self.recentTabBarItem.setTitleTextAttributes(attrs, for: .normal)
        self.weeklyTabBarItem.setTitleTextAttributes(attrs, for: .normal)
        self.topTabBar.selectedItem = self.recentTabBarItem
        let topTabBarFrameSize = self.topTabBar.frame.size
        let topTabBarItemWidth = topTabBarFrameSize.width / CGFloat(topTabBarItems.count)
        let tabBarSize = CGSize(
            width: topTabBarFrameSize.width / CGFloat(topTabBarItems.count),
            height: self.topTabBar.frame.height
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
        self.topTabBar.selectionIndicatorImage = selectionIndicatorImage
    }

}

// MARK: - UITabBarDelegate
extension ActivityViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        self.currentTabBarIndex = index
        switch index {
        case TabBar.recentIndex:
            self.recentActivityViewControllerContainerView.isHidden = false
            self.weeklyActivityViewControllerContainerView.isHidden = true
            break
        case TabBar.weeklyIndex:
            self.recentActivityViewControllerContainerView.isHidden = true
            self.weeklyActivityViewControllerContainerView.isHidden = false
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
