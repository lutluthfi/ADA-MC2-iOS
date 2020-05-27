//
//  PrivacyPolicyViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 26/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    lazy var backBarButtonItem: UIBarButtonItem = {
        return .init(image: UIImage(
            systemName: "chevron.left"),
                     style: .done,
                     target: self,
                     action: #selector(self.onBackBarButtonItemTapped(_:))
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Privacy Policy"
        self.navigationItem.leftBarButtonItems = [self.backBarButtonItem]
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.view.backgroundColor = .white
    }
    
    @objc private func onBackBarButtonItemTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
