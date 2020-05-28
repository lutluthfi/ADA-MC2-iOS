//
//  PracticeViewController.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 19/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import ARKit
import AVFoundation
import Foundation
import SceneKit
import UIKit

extension PracticeViewController {
    class CollectionView {
        static var filterPracticeCollectionViewCellUINib: UINib = {
            return .init(
                nibName: FilterPracticeCollectionViewCell.identifier,
                bundle: nil
            )
        }()
    }
    class Pracice {
        enum Instruction: String, CaseIterable {
            case finish = "Finish!"
            case getReady = "Get Ready!"
            case oneCounter = "1"
            case sideToSideLeft = "Look at to your left"
            case sideToSideRight = "Look at to your right"
            case start = "Start"
            case threeCounter = "3"
            case twoCounter = "2"
        }
        static let sideToSideNeckStretchInstructions: [Instruction] = [
            .getReady,
            .threeCounter,
            .twoCounter,
            .oneCounter,
            .start,
            .sideToSideLeft,
            .sideToSideLeft,
            .sideToSideLeft,
            .sideToSideLeft,
            .sideToSideLeft,
            .sideToSideLeft,
            .sideToSideLeft,
            .sideToSideLeft,
            .sideToSideRight,
            .sideToSideRight,
            .sideToSideRight,
            .sideToSideRight,
            .sideToSideRight,
            .sideToSideRight,
            .sideToSideRight,
            .sideToSideRight,
            .finish
        ]
    }
}

class PracticeViewController: UIViewController {
    
    lazy var arscnView: ARSCNView = {
        let view = ARSCNView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.session.delegate = self
        view.automaticallyUpdatesLighting = true
        return view
    }()
    lazy var backBarButtonItem: UIBarButtonItem = {
        return .init(
            image: UIImage(systemName: "chevron.left"),
            style: .done,
            target: self,
            action: #selector(self.onBackBarButtonItemTapped(_:))
        )
    }()
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = ScaledCollectionFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 32
        collectionViewLayout.transformScale = 0.5
        collectionViewLayout.isPagingEnabled = true
        collectionViewLayout.minimumAlpha = 0.5
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CollectionView.filterPracticeCollectionViewCellUINib,
            forCellWithReuseIdentifier: FilterPracticeCollectionViewCell.identifier
        )
        return collectionView
    }()
    lazy var deskHittedSoundUrl: URL = {
        let bundle = Bundle.main.path(forResource: "DeskHitted", ofType: "m4a")!
        return .init(fileURLWithPath: bundle)
    }()
    lazy var instructionContainerView: UIVisualEffectView = {
        let view = UIVisualEffectView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = UIBlurEffect(style: .dark)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    lazy var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private var audioPlayer: AVAudioPlayer?
    private var currentFaceAnchor: ARFaceAnchor?
    private var contentNode: SCNNode?
    private lazy var eyeLeftNode = self.contentNode!.childNode(withName: "eyeLeft", recursively: true)!
    private lazy var eyeRightNode = self.contentNode!.childNode(withName: "eyeRight", recursively: true)!
    private lazy var jawNode = self.contentNode!.childNode(withName: "jaw", recursively: true)!
    private lazy var jawHeight: Float = {
        let (min, max) = self.jawNode.boundingBox
        return max.y - min.y
    }()
    private var originalJawY: Float = 0
    private var timer: Timer?
    
    private var playedCounter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItems = [self.backBarButtonItem]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupViewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.practiceDidStop()
    }
    
    @objc private func onBackBarButtonItemTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupViewDidLoad() {
        self.implementComponentView()
        self.collectionView.scrollToItem(
            at: .init(row: 0, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
        self.instructionLabel.text = "Place your iPhone on something that is truly horizontal"
    }
    
    private func setupViewDidAppear() {
        UIApplication.shared.isIdleTimerDisabled = true
        self.arDidResetTracking()
    }
    
    private func arDidResetTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        self.arscnView.session.run(
            configuration,
            options: [.resetTracking, .removeExistingAnchors]
        )
    }
    
    private func deksHittedSoundDidPlay() {
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: self.deskHittedSoundUrl)
            self.audioPlayer?.prepareToPlay()
            self.audioPlayer?.play()
        } catch {
        }
    }
    
    private func practiceDidComplete() {
        self.practiceDidStop()
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { (_) in
            // go to result page
        }
        let alertController = UIAlertController(
            title: "Complete!",
            message: "You have just completed Side to Side Turn Neck Stretch 🔥",
            preferredStyle: .alert
        )
        alertController.addAction(okAlertAction)
        self.present(alertController, animated: true)
    }
    
    private func practiceDidStart() {
        self.collectionView.isScrollEnabled = false
        self.timer = Timer
            .scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                if self.playedCounter >= Pracice.sideToSideNeckStretchInstructions.count {
                    self.practiceDidComplete()
                    return
                }
                self.deksHittedSoundDidPlay()
                let foo = Pracice.sideToSideNeckStretchInstructions[self.playedCounter]
                self.instructionLabel.text = foo.rawValue
                self.playedCounter += 1
            })
    }
    
    private func practiceDidStop() {
        self.playedCounter = 0
        self.collectionView.isScrollEnabled = true
        self.timer?.invalidate()
    }
}

// MARK: - Implement Component View
extension PracticeViewController {
    private func implementComponentView() {
        defer {
            self.view.layoutIfNeeded()
        }
        
        self.view.addSubview(self.arscnView)
        self.view.addSubview(self.instructionContainerView)
        self.view.addSubview(self.collectionView)
        self.instructionContainerView.contentView.addSubview(self.instructionLabel)
        NSLayoutConstraint.activate([
            self.arscnView
                .leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor),
            self.arscnView
                .topAnchor
                .constraint(equalTo: self.view.topAnchor),
            self.arscnView
                .trailingAnchor
                .constraint(equalTo: self.view.trailingAnchor),
            self.arscnView
                .bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor),
            self.instructionContainerView
                .centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            self.instructionContainerView
                .leadingAnchor
                .constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 16),
            self.instructionContainerView
                .trailingAnchor
                .constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -16),
            self.instructionContainerView
                .bottomAnchor
                .constraint(equalTo: self.collectionView.topAnchor, constant: -16),
            self.collectionView
                .heightAnchor
                .constraint(equalToConstant: 150),
            self.collectionView
                .leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor),
            self.collectionView
                .trailingAnchor
                .constraint(equalTo: self.view.trailingAnchor),
            self.collectionView
                .bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.instructionLabel
                .leadingAnchor
                .constraint(
                    equalTo: self.instructionContainerView.contentView.leadingAnchor,
                    constant: 16
            ),
            self.instructionLabel
                .topAnchor
                .constraint(
                    equalTo: self.instructionContainerView.contentView.topAnchor,
                    constant: 16
            ),
            self.instructionLabel
                .trailingAnchor
                .constraint(
                    equalTo: self.instructionContainerView.contentView.trailingAnchor,
                    constant: -16
            ),
            self.instructionLabel
                .bottomAnchor
                .constraint(
                    equalTo: self.instructionContainerView.contentView.bottomAnchor,
                    constant: -16
            )
        ])
    }
}

// MARK: - ARSCNViewDelegate
extension PracticeViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard anchor is ARFaceAnchor else { return nil }
        self.contentNode = SCNReferenceNode(named: "robotHead")
        self.originalJawY = self.jawNode.position.y
        return self.contentNode
    }
    
    func renderer(
        _ renderer: SCNSceneRenderer,
        didUpdate node: SCNNode,
        for anchor: ARAnchor
    ) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        let blendShapes = faceAnchor.blendShapes
        guard let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
            let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float,
            let jawOpen = blendShapes[.jawOpen] as? Float
            else { return }
        self.eyeLeftNode.scale.y = 1 - eyeBlinkLeft
        self.eyeRightNode.scale.y = 1 - eyeBlinkRight
        self.jawNode.scale.y = 1 + jawOpen
        
        let xLookAtPoint = faceAnchor.lookAtPoint.x
        let yLookAtPoint = faceAnchor.lookAtPoint.y
        if -0.05...0.05 ~= xLookAtPoint && -0.05...0.05 ~= yLookAtPoint {
            // self.faceLabel.text = "Kamu tidak menghadap kemana-mana"
        }
        if xLookAtPoint > 0.4 {
            // self.faceLabel.text = "Kamu menghadap ke kiri"
        } else if xLookAtPoint < -0.4 {
            // self.faceLabel.text = "Kamu menghadap ke kanan"
        }
        if yLookAtPoint > 0.3 {
            // self.faceLabel.text = "Kamu menghadap ke bawah"
        } else if yLookAtPoint < -0.3 {
            // self.faceLabel.text = "Kamu menghadap ke atas"
        }
    }
}

// MARK: - ARSessionDelegate
extension PracticeViewController: ARSessionDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension PracticeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = FilterPracticeCollectionViewCell.height
        let width = FilterPracticeCollectionViewCell.height
        return .init(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let identifier = FilterPracticeCollectionViewCell.identifier
        let reusableCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
            ) as? FilterPracticeCollectionViewCell
        guard let cell = reusableCell else {
            fatalError("Cannot dequeue reusable cell \(identifier) with reuseIdentifier: \(identifier)")
        }
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        self.practiceDidStart()
    }
}

extension SCNReferenceNode {
    convenience init(named resourceName: String, loadImmediately: Bool = true) {
        let url = Bundle.main.url(forResource: resourceName,
                                  withExtension: "scn",
                                  subdirectory: "SceneAssets.scnassets")!
        self.init(url: url)!
        if loadImmediately {
            SCNTransaction.begin()
            self.load()
            SCNTransaction.commit()
        }
    }
}
