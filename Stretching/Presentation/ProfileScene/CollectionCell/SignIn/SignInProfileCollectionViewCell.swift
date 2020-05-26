//
//  SignInProfileCollectionViewCell.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 24/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import AuthenticationServices
import UIKit

protocol SignInProfileCollectionViewCellDelegate: class {
    func signInProfile(_ cell: UICollectionViewCell, onTouchedUpInside button: UIButton)
}

class SignInProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing:
        SignInProfileCollectionViewCell.self
    )
    static let height = CGFloat(64)
    
    lazy var signInButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(self.onSingInButtonTouchedUpInside(_:)),
            for: .touchUpInside
        )
        return button
    }()
    
    weak var delegate: SignInProfileCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.implementComponentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onSingInButtonTouchedUpInside(_ sender: UIButton) {
        self.delegate?.signInProfile(self, onTouchedUpInside: sender)
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        let height = SignInProfileCollectionViewCell.height
        let width = layoutAttributes.frame.width
        let targetSize = CGSize(width: width, height: height)
        layoutAttributes.frame.size = self.contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return layoutAttributes
    }
}

extension SignInProfileCollectionViewCell {
    private func implementComponentView() {
        defer {
            self.layoutIfNeeded()
        }
        
        self.contentView.addSubview(self.signInButton)
        NSLayoutConstraint.activate([
            self.signInButton
                .heightAnchor
                .constraint(equalToConstant: 48),
            self.signInButton
                .leadingAnchor
                .constraint(equalTo: self.contentView.leadingAnchor),
            self.signInButton
                .trailingAnchor
                .constraint(equalTo: self.contentView.trailingAnchor),
            self.signInButton
                .bottomAnchor
                .constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
