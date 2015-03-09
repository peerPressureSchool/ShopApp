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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var apiSearchForBestBuyProducts : [(name:String, sku:String, productDesc: String, price: Double, imgUrl : UIImage)] = []
    
    var jsonResponse:NSDictionary!
    
    var dataController = DataController()

    //paramters to build toggle of call
    var url = NSURL()
    var departmentID = arc4random_uniform(10) + 1

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
    
    //make the api call to get products from best buy
    
    func makeRequest () {
        
        //create random number to pic a dept
        
        
        //create call
      
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        
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
    
    // toggling across feeds -- might need to add makeRequest()
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
            case 0: url = NSURL(string: "http://api.remix.bestbuy.com/v1/products(departmentId=\(departmentID))?show=sku,name,description,regularPrice,longDescription,largeImage&pageSize=15&page=1&apiKey=\(kApiKey)&format=json")!;
                makeRequest();
            
            //should change this call to something else for "trending area"
            case 1: url = NSURL(string: "http://api.remix.bestbuy.com/v1/products(departmentId=\(departmentID))?show=sku,name,description,regularPrice,longDescription,largeImage&pageSize=15&page=1&apiKey=\(kApiKey)&format=json")!;
                makeRequest();
            
        default: break;
        }
    }
}

