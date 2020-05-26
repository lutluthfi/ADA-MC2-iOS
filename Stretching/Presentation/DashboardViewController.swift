//
//  DashboardViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 23/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardViewControllerDelegate: class {
    func showGuidePageScene()
}

class DashboardViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
    private func setupViewDidLoad() {
        guard let viewControllers = self.viewControllers else { return }
        let exploreViewController = (viewControllers[0] as? UINavigationController)?
            .viewControllers
            .first as? ExploreViewController
        if let exploreViewController = exploreViewController {
            exploreViewController.delegate = self
        }
    }
    
    private func setupViewWillAppear() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupViewWillDisappear() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - DashboardViewControllerDelegate
extension DashboardViewController: DashboardViewControllerDelegate {
    func showGuidePageScene() {
        let storyboard = UIStoryboard(name: "GuidePageStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            identifier: String(describing: GuidePageViewController.self)
        )
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
