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
    
    var images = ["1boarding", "2boarding", "3boarding"]
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.startButton.layer.cornerRadius = 17.5
        self.scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false

            //crete the slides and add them
            var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

            for index in 0..<images.count {
                
                frame.origin.x = scrollWidth * CGFloat(index)
                frame.size = CGSize(width: scrollWidth, height: scrollHeight)

                let slide = UIView(frame: frame)

                //subviews
                let imageView = UIImageView.init(image: UIImage.init(named: images[index]))
                imageView.frame = CGRect(x:0,y:0,width:300,height:scrollHeight)
                imageView.contentMode = .scaleAspectFit
                imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)

                slide.addSubview(imageView)
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

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasLaunched")
    }
    
}
