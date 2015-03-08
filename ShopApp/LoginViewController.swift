//
//  LoginViewController.swift
//  ShopApp
//
//  Created by Boris Khomut on 3/6/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var loginImageView: UIImageView!
    
    
    /// images that correspond to the selected page.
        
    let images = [
        UIImage(named: "cloud1.png"),
        UIImage(named: "cloud2.png"),
        UIImage(named: "cloud3.png")
    ]
    
    // MARK: View Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.loginImageView.frame = CGRectMake(0,0,100,100)
        self.loginImageView.image = images[0]
//        self.loginImageView.contentMode = .ScaleAspectFit
        
        configurePageControl()
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Configuration
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available images we have.
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        self.loginImageView.image = images[pageControl.currentPage]

        
        pageControl.tintColor = UIColor.blueColor()
        pageControl.pageIndicatorTintColor = UIColor.greenColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        
//        pageControl.addTarget(self, action: "pageControlValueDidChange", forControlEvents: .ValueChanged)
    }

    
    // MARK: Actions
    
//    func pageControlValueDidChange() {
//        NSLog("The page control changed its current page to \(pageControl.currentPage).")
//
//        self.loginImageView.image = images[pageControl.currentPage]
//
//    }
    
    
    // MARK: Recognize Swipe
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
                self.loginImageView.image = images[pageControl.currentPage--]
                println("The page control changed its current page to \(pageControl.currentPage).")
            
            case UISwipeGestureRecognizerDirection.Left:
                println("Swiped left")
                self.loginImageView.image = images[pageControl.currentPage++]
                println("The page control changed its current page to \(pageControl.currentPage).")
            
            default:
                break
            }
        }
    }
    
    
    // MARK: Login Button Pressed
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("loginSegue", sender: nil)
    }
        
}
