//
//  CartCell.swift
//  ShopApp
//
//  Created by Jared Mermey on 2/15/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    
    //cell components
    @IBOutlet weak var productNameInCartLabel: UILabel!
    @IBOutlet weak var productPriceInCartLabel: UILabel!
    @IBOutlet weak var productImageInCartImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeLeft)
    }
    
    //populate cell2
    
    func setCell2(productNameLabelText: String, productPriceLabelText: Float, productImageName: String, productDescriptionLabelText: String) {
        
        self.productNameInCartLabel.text = productNameLabelText
        self.productPriceInCartLabel.text = "$\(productPriceLabelText)"
        self.productImageInCartImage.image = UIImage(named: productImageName)
               
    }
    
    // actions
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Buy \(self.productNameInCartLabel.text)")
                //write code to purchase product -- first an alert then a Swipe call
                //write code to drag cell while swiping
            case UISwipeGestureRecognizerDirection.Left:
                println("Remove \(self.productNameInCartLabel.text) from cart")
                //write code to remove product from cart tuple
                //write code to drag cell while swiping
            default:
                break
            }
        }
    }
}
