//
//  OnboardingViewController.swift
//  Stretching
//
//  Created by Arie May Wibowo on 11/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleOnboarding: UILabel!
    @IBOutlet weak var descriptionOnboarding: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    let degree360: CGFloat! = 6.28319
    
    let firstConstantMove: CGFloat = 65.9
    let secondConstantMove: CGFloat = 131.8
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var slide = UIView()
    
    var imageViewOne: UIImageView?
    var imageViewTwo: UIImageView?
    var imageViewThree: UIImageView?
    var indexPosition: Int?
    
    let imageOne: [UIImage] = [#imageLiteral(resourceName: "1onboard-1choosetechnique"), #imageLiteral(resourceName: "1onboard-2choosetechnique"), #imageLiteral(resourceName: "1onboard-3choosetechnique")]
    let imageTwo: [UIImage] = [#imageLiteral(resourceName: "2onboard-1Startpracticing"), #imageLiteral(resourceName: "2onboard-2Startpracticing"), #imageLiteral(resourceName: "2onboard-3Startpracticing")]
    let imageThree: [UIImage] = [#imageLiteral(resourceName: "3onboard-1 progress"), #imageLiteral(resourceName: "3onboard-2progress")]
    
    let images = [
        "1boarding",
        "2boarding",
        "3boarding"
    ]
    let onTitle = [
        "Choose techniques",
        "Start practicing",
        "See your progress"
    ]
    let onDescription = [
        "Choose the stretch techniques you curious to learn. We have what you need from neck to wrist stretch",
        "Set your phone in a potrait way and put it on the desk. We’ll guide and notify you through the stretch process with our AR. Less risk of injury!",
        "Track your flexibility enhancement. Find yourself more flexible throughout time"
    ]
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.startButton.layer.cornerRadius = 17.5
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        imageViewOne = UIImageView()
        let loadingImageOne = imageOne.map { $0 }
        imageViewOne?.animationImages = loadingImageOne
        imageViewOne?.animationDuration = 1.0
        imageViewOne?.startAnimating()
        
        imageViewTwo = UIImageView()
        let loadingImageTwo = imageTwo.map { $0 }
        imageViewTwo?.animationImages = loadingImageTwo
        imageViewTwo?.animationDuration = 1.0
        imageViewTwo?.startAnimating()
        
        imageViewThree = UIImageView()
        let loadingImageThree = imageThree.map { $0 }
        imageViewThree?.animationImages = loadingImageThree
        imageViewThree?.animationDuration = 1.0
        imageViewThree?.startAnimating()
        
        let Array: [UIImageView] = [imageViewOne!, imageViewTwo!, imageViewThree!]
        
        self.titleOnboarding.text = onTitle[0]
        self.descriptionOnboarding.text = onDescription[0]
        
        //crete the slides and add them
        for index in 0..<images.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let imageContainer = Array[index]
            imageContainer.frame = CGRect(x:0,y:0,width:300,height:scrollHeight)
            imageContainer.contentMode = .scaleAspectFit
            imageContainer.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)

            
            slide = UIView(frame: frame)
            slide.addSubview(imageContainer)
            scrollView.addSubview(slide)
        }
        
        
        
        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(images.count), height: scrollHeight)
        
        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0
        
        //initial state
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position: CGFloat = scrollView.contentOffset.x
        
        if (position > 0.0) && (position <= 414.0) {
            self.startButton.setTitle("Skip", for: .normal)
            self.startButton.backgroundColor = .clear
            self.startButton.setTitleColor(
                UIColor(red: 255/255, green: 99/255, blue: 72/255, alpha: 1),
                for: .normal
            )
            self.titleOnboarding.text = onTitle[1]
            self.descriptionOnboarding.text = onDescription[1]
            imageViewOne!.transform = CGAffineTransform(rotationAngle: position / firstConstantMove)
            imageViewTwo!.transform = CGAffineTransform(rotationAngle: position / firstConstantMove)
            imageViewThree!.transform = CGAffineTransform(rotationAngle: position / firstConstantMove)
        } else if (position > 414.0) && (position <= 818.0) {
            self.startButton.setTitle("Let's Start", for: .normal)
            self.startButton.backgroundColor = UIColor(red: 255/255, green: 99/255, blue: 72/255, alpha: 1)
            self.startButton.setTitleColor(.white, for: .normal)
            self.titleOnboarding.text = onTitle[2]
            self.descriptionOnboarding.text = onDescription[2]
            imageViewOne!.transform = CGAffineTransform(rotationAngle: position / secondConstantMove)
            imageViewTwo!.transform = CGAffineTransform(rotationAngle: position / secondConstantMove)
            imageViewThree!.transform = CGAffineTransform(rotationAngle: position / secondConstantMove)
        } else if (position == 0.0) {
            self.startButton.setTitle("Skip", for: .normal)
            self.startButton.backgroundColor = .clear
            self.startButton.setTitleColor(
                UIColor(red: 255/255, green: 99/255, blue: 72/255, alpha: 1),
                for: .normal
            )
            self.titleOnboarding.text = onTitle[0]
            self.descriptionOnboarding.text = onDescription[0]
        }
        
    }
    
    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasLaunched")
        performSegue(withIdentifier: "toMainPage", sender:  nil)
    }
    
}
