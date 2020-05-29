//
//  ResultPracticeViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 29/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class ResultPracticeViewController: UIViewController {

    @IBOutlet weak var exploreMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exploreMoreButton.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func onExploreMoreButtonTouchedUpInside(_ sender: UIButton) {
        let dashboardViewController = self.navigationController?.viewControllers.filter({ $0 is DashboardViewController }).first
        guard let unwrappedDashboardViewController = dashboardViewController else { return }
        self.navigationController?.popToViewController(unwrappedDashboardViewController, animated: true)
    }
}
