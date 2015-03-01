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
    }
    
    //populate cell2
    
    func setCell2(productNameLabelText: String, productPriceLabelText: Float, productImageName: String, productDescriptionLabelText: String) {
        
        self.productNameInCartLabel.text = productNameLabelText
        self.productPriceInCartLabel.text = "$\(productPriceLabelText)"
        self.productImageInCartImage.image = UIImage(named: productImageName)
               
    }

}
