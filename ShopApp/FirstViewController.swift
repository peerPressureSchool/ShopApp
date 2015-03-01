//
//  FirstViewController.swift
//  ShopApp
//
//  Created by Jared Mermey on 2/14/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    @IBOutlet weak var myTableView: UITableView!
    
    let kApiKey = "3he27h6jg6kysxxyueqhhvza"
    
    var productArray: [Product] = [Product]()
    var cartArray: [Product] = [Product]()
    
    var apiSearchForBestBuyProducts : [(name:String, sku:String, productDesc: String, price: Double, imgUrl : UIImage)] = []
    
    var jsonResponse:NSDictionary!
    
    var dataController = DataController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.backgroundColor = UIColor.whiteColor()
        
        //call function to make API call, for loop both build product array and saves product to CD
        self.setUpProducts()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpProducts()
    {
        //API Call
        makeRequest()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //var rows = self.productArray.count
        return self.apiSearchForBestBuyProducts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        cell.selectionStyle = .None
        
       cell.setCell(apiSearchForBestBuyProducts[indexPath.row].name, productPriceLabelText: apiSearchForBestBuyProducts[indexPath.row].price, productImageName: apiSearchForBestBuyProducts[indexPath.row].imgUrl, productDescriptionLabelText: apiSearchForBestBuyProducts[indexPath.row].productDesc)
        
        return cell
    }
    
    //swipe right to add to add to cart
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        // 1
        var addToCartAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Add to Cart" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 2 Adds products to Cart Array...refactor once cart created on cart VC to add/remove value there
            
           let sku = self.apiSearchForBestBuyProducts[indexPath.row].sku
           self.dataController.saveBestBuyItemForSku(sku, json: self.jsonResponse)
         

            
            
            
//            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
//            
//            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
//            
//            shareMenu.addAction(twitterAction)
//            shareMenu.addAction(cancelAction)
//            
//            
//            self.presentViewController(shareMenu, animated: true, completion: nil)
        })
        // 3
//        var rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Rate" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
//            // 4
//            let rateMenu = UIAlertController(title: nil, message: "Rate this App", preferredStyle: .ActionSheet)
//            
//            let appRateAction = UIAlertAction(title: "Rate", style: UIAlertActionStyle.Default, handler: nil)
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
//            
//            rateMenu.addAction(appRateAction)
//            rateMenu.addAction(cancelAction)
//            
//            
//            self.presentViewController(rateMenu, animated: true, completion: nil)
//        })
        // 5
        return [addToCartAction]
    }

    
    func makeRequest () {
        
        //create random number to pic a dept
        var departmentID = arc4random_uniform(10) + 1
        
        //create call
        let url = NSURL(string: "http://api.remix.bestbuy.com/v1/products(departmentId=\(departmentID))?show=sku,name,description,regularPrice,longDescription,largeImage&pageSize=15&page=1&apiKey=\(kApiKey)&format=json")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
        
        //decode return data
        var stringData = NSString(data: data, encoding: NSUTF8StringEncoding)
        
        var conversionError: NSError?
        
        //turn return data in JSON
        var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &conversionError) as? NSDictionary
            
            
        println(jsonDictionary)
        
            if conversionError != nil {
                println(conversionError!.localizedDescription)
                let errorString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error in Parsing \(errorString)")
            }
            else {
                if jsonDictionary != nil {
                    
                    self.jsonResponse = jsonDictionary!
                    self.apiSearchForBestBuyProducts = DataController.jsonAsBestBuyProductPull(jsonDictionary!)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.myTableView.reloadData()
                    })
                    
                }
                else {
                    let errorString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error Could not Parse JSON \(errorString)")
                }                
            }
            
            
        })
        //execute call
        task.resume()

    }
}

