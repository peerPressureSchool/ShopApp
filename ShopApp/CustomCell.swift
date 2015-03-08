//
//  CustomCell.swift
//  ShopApp
//
//  Created by Jared Mermey on 2/14/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    //product information
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    //referrers
    @IBOutlet weak var ref1Image: UIImageView!
    @IBOutlet weak var ref2Image: UIImageView!
    @IBOutlet weak var ref3Image: UIImageView!
    @IBOutlet weak var ref4Image: UIImageView!
    @IBOutlet weak var ref5Image: UIImageView!
    @IBOutlet weak var ref6Image: UIImageView!
    @IBOutlet weak var ref7Image: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        // Configure the view for the selected state
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeLeft)
        
    }

    //populate the cell
    
    func setCell(productNameLabelText: String, productPriceLabelText: Double, productImageName: UIImage, productDescriptionLabelText: String) {
                
        self.productNameLabel.text = productNameLabelText
        self.productPriceLabel.text = "$\(productPriceLabelText)"
        self.productImage.image = productImageName
        self.productImage.contentMode = .ScaleAspectFit
        self.productDescriptionLabel.text = productDescriptionLabelText
        
        }

    //actions
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println(self.productNameLabel.text)
                //write code to add to cart
                //write code to drag cell while swiping
            case UISwipeGestureRecognizerDirection.Left:
                println("Swiped left")
                //write code to add to share
                //write code to drag cell while swiping
            default:
                break
            }
        }
    }
}
