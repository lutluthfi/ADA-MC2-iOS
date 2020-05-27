//
//  TermsConditionsViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 26/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class TermsConditionsViewController: UIViewController {
    
    @IBOutlet weak var termsConditionsLabel: UILabel!
    
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
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Terms & Conditions"
        self.navigationItem.leftBarButtonItems = [self.backBarButtonItem]
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.view.backgroundColor = .white // removing black flashes
    }
    
    @objc private func onBackBarButtonItemTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupViewDidLoad() {
        let introductionString = "Introduction"
        let intellectualPropertyRightsString = "Intellectual Property Rights"
        let restrictionsString = "Restrictions"
        let termsConditionsContentString = "Introduction\n" +
            "These Website Standard Terms and Conditions written on this webpage shall manage your use of our website, Webiste Name accessible at Website.com.\n\n" +
            "These Terms will be applied fully and affect to your use of this Website. By using this Website, you agreed to accept all terms and conditions written in here. You must not use this Website if you disagree with any of these Website Standard Terms and Conditions.\n\n" +
            "Minors or people below 18 years old are not allowed to use this Website.\n\n" +
            "Intellectual Property Rights\n" +
            "Other than the content you own, under these Terms, Company Name and/or its licensors own all the intellectual property rights and materials contained in this Website.\n\n" +
            "You are granted limited license only for purposes of viewing the material contained on this Website.\n\n" +
            "Restrictions\n" +
            "You are specifically restricted from all of the following"
        let termsConditionsContentAttributedString = NSMutableAttributedString(
            string: termsConditionsContentString
        )
        if let sectionFont = UIFont(name: "Montserrat-Bold", size: 18) {
            let introductionStringRange = (termsConditionsContentString as NSString)
                .range(of: introductionString)
            let intellectualPropertyRightsStringRange = (termsConditionsContentString as NSString)
                .range(of: intellectualPropertyRightsString)
            let restrictionsStringRange = (termsConditionsContentString as NSString)
                .range(of: restrictionsString)
            let attrs =  [
                NSAttributedString.Key.font : sectionFont,
                NSAttributedString.Key.foregroundColor : StretchingAssetKit.Color.colorPrimaryOrangeDark
            ]
            termsConditionsContentAttributedString
                .addAttributes(attrs, range: introductionStringRange)
            termsConditionsContentAttributedString
                .addAttributes(attrs, range: intellectualPropertyRightsStringRange)
                termsConditionsContentAttributedString
                    .addAttributes(attrs, range: restrictionsStringRange)
        }
        self.termsConditionsLabel.attributedText = termsConditionsContentAttributedString
    }
}
