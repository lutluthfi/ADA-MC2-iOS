//
//  ProfileViewController.swift
//  Stretching
//
//  Created by Steven Rafaelie on 18/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import AuthenticationServices
import UIKit

extension ProfileViewController {
    class CollectionView {
        struct Account {
            let email: String
            let fullName: String
        }
        
        static let accountSection = 1
        static let generalSection = 2
        static let settingSection = 3
        static let signInSection = 0
        
        static func sections() -> [Int] {
            return [
                self.accountSection,
                self.generalSection,
                self.settingSection,
                self.signInSection
            ]
        }
        
        static var accountProfileCollectionViewUINib: UINib = {
            return .init(
                nibName: AccountProfileCollectionViewCell.identifier,
                bundle: nil
            )
        }()
        static var commonProfileCollectionViewUINib: UINib = {
            return .init(
                nibName: CommonProfileCollectionViewCell.identifier,
                bundle: nil
            )
        }()
        static var headerCommonProfileCollectionViewUINib: UINib = {
            return .init(
                nibName: HeaderCommonProfileCollectionReusableView.identifier,
                bundle: nil
            )
        }()
        static var signInProfileCollectionViewUINib: UINib = {
            return .init(
                nibName: SignInProfileCollectionViewCell.identifier,
                bundle: nil
            )
        }()
        static var signOutProfileCollectionViewUINib: UINib = {
            return .init(
                nibName: SignOutProfileCollectionViewCell.identifier,
                bundle: nil
            )
        }()
    }
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: DashboardViewControllerDelegate?
    private var displayedAccount: ProfileViewController.CollectionView.Account?
    private let displayedGeneralItems: [String] = [
        "Terms & Conditions",
        "Privacy Policy",
        "Rate Our App"
    ]
    private let displayedSettingItems: [String] = [
        "Notification",
        "Account Privacy"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    private func setupViewDidLoad() {
        let email = KeyChainStorage.load(key: .appleIDEmail)
        let fullName = KeyChainStorage.load(key: .appleIDFullName)
        if let email = email,
            !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let fullName = fullName,
            !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.displayedAccount = .init(email: email, fullName: fullName)
        }
        
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            CollectionView.accountProfileCollectionViewUINib,
            forCellWithReuseIdentifier: AccountProfileCollectionViewCell.identifier
        )
        self.collectionView.register(
            CollectionView.commonProfileCollectionViewUINib,
            forCellWithReuseIdentifier: CommonProfileCollectionViewCell.identifier
        )
        self.collectionView.register(
            CollectionView.headerCommonProfileCollectionViewUINib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCommonProfileCollectionReusableView.identifier
        )
        self.collectionView.register(
            SignInProfileCollectionViewCell.self,
            forCellWithReuseIdentifier: SignInProfileCollectionViewCell.identifier
        )
        self.collectionView.register(
            CollectionView.signOutProfileCollectionViewUINib,
            forCellWithReuseIdentifier: SignOutProfileCollectionViewCell.identifier
        )
    }
}

// MARK: - SignInProfileCollectionViewCellDelegate
extension ProfileViewController: SignInProfileCollectionViewCellDelegate {
    func signInProfile(_ cell: UICollectionViewCell, onTouchedUpInside button: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension ProfileViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential
        if let appleIDCredential = appleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
            let email = appleIDCredential.email ?? ""
            if let emailData = email.data(using: .utf8) {
                _ = KeyChainStorage.save(key: .appleIDEmail, data: emailData)
            }
            if let fullNameData = fullName.data(using: .utf8) {
                _ = KeyChainStorage.save(key: .appleIDFullName, data: fullNameData)
            }
            if let userIdentifierData = userIdentifier.data(using: .utf8) {
                _ = KeyChainStorage.save(key: .appleIDUserIdentifier, data: userIdentifierData)
            }
            self.displayedAccount = .init(email: email, fullName: fullName)
            self.collectionView.reloadData()
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CollectionView.sections().count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case CollectionView.accountSection:
            return self.displayedAccount == nil ? 0 : 1
        case CollectionView.generalSection:
            return self.displayedGeneralItems.count
        case CollectionView.settingSection:
            return self.displayedSettingItems.count
        case CollectionView.signInSection:
            return self.displayedAccount == nil ? 1 : 0
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        switch section {
        case CollectionView.generalSection,
             CollectionView.settingSection:
            let width = collectionView.frame.width - 32
            let height = HeaderCommonProfileCollectionReusableView.height
            return .init(width: width, height: height)
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch indexPath.section {
        case CollectionView.generalSection,
             CollectionView.settingSection:
            let identifier = HeaderCommonProfileCollectionReusableView.identifier
            let reusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? HeaderCommonProfileCollectionReusableView
            guard let view = reusableView else { fatalError() }
            var title = "[Title]"
            switch indexPath.section {
            case CollectionView.generalSection:
                title = "General"
                break
            case CollectionView.settingSection:
                title = "Setting"
                break
            default:
                break
            }
            view.fill(with: title)
            return view
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.section {
        case CollectionView.accountSection:
            let width = collectionView.frame.width - 32
            let height = AccountProfileCollectionViewCell.height
            return .init(width: width, height: height)
        case CollectionView.generalSection,
             CollectionView.settingSection:
            let width = collectionView.frame.width - 32
            let height = CommonProfileCollectionViewCell.height
            return .init(width: width, height: height)
        case CollectionView.signInSection:
            let width = collectionView.frame.width - 32
            let height = SignInProfileCollectionViewCell.height
            return .init(width: width, height: height)
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case CollectionView.accountSection:
            let identifier = AccountProfileCollectionViewCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? AccountProfileCollectionViewCell
            guard let cell = reusableCell else { fatalError() }
            if let displayedAccount = self.displayedAccount {
                cell.fill(
                    with: displayedAccount.fullName,
                    email: displayedAccount.email,
                    photo: UIImage()
                )
            }
            return cell
        case CollectionView.generalSection, CollectionView.settingSection:
            let identifier = CommonProfileCollectionViewCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? CommonProfileCollectionViewCell
            guard let cell = reusableCell else { fatalError() }
            var item = "[Title]"
            switch indexPath.section {
            case CollectionView.generalSection:
                item = self.displayedGeneralItems[indexPath.row]
                break
            case CollectionView.settingSection:
                item = self.displayedSettingItems[indexPath.row]
                break
            default:
                break
            }
            cell.fill(with: item)
            return cell
        case CollectionView.signInSection:
            let identifier = SignInProfileCollectionViewCell.identifier
            let reusableCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier,
                for: indexPath
            ) as? SignInProfileCollectionViewCell
            guard let cell = reusableCell else { fatalError() }
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case CollectionView.generalSection:
            switch self.displayedGeneralItems[row] {
            case "Terms & Conditions":
                self.delegate?.showTermsConditionsScene()
                break
            case "Privacy Policy":
                break
            default:
                break
            }
            break
        default:
            break
        }
    }
}
