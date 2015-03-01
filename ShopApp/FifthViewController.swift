//
//  FifthViewController.swift
//  ShopApp
//
//  Created by Jared Mermey on 2/15/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myCartTableview: UITableView!
    var cartItemsArray: [Product] = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       // self.setUpCartItems()
        println(cartItemsArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func setUpCartItems()
//    {
//        
//    }
//    
    
    //tableview functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cartRows = cartItemsArray.count
        return cartRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell2 : CartCell = tableView.dequeueReusableCellWithIdentifier("Cell2") as CartCell
        let productFromCartArray = cartItemsArray[indexPath.row]
        
        //cell2.setCell2(productFromCartArray.name, productPriceLabelText: productFromCartArray.price, productImageName: productFromCartArray.imageName, productDescriptionLabelText: productFromCartArray.productDescription)
        
        return cell2
    }

}
