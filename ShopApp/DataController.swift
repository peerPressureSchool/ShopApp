//
//  DataController.swift
//  ShopApp
//
//  Created by Jared Mermey on 2/16/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataController {
    
    class func jsonAsBestBuyProductPull (json : NSDictionary) -> [(name: String, sku : String, productDesc: String, price: Double, imgUrl : UIImage)]{
        
        var bestBuyProductPullArray: [(name: String, sku: String, productDesc: String, price: Double, imgUrl : UIImage)] = []
        var pullResult: (name: String, sku: String, productDesc: String, price: Double, imgUrl : UIImage)
        
        if json["products"] != nil {
            let results : [AnyObject] = json["products"]! as [AnyObject]
            
            for productDiciontary in results {
                
                if productDiciontary["sku"] != nil  {
                    
                    let name: String = productDiciontary["name"]! as String
                    let sku: Int = productDiciontary["sku"]! as Int
                    let skuString = String(sku)
                    
                    let productDesc: String = productDiciontary["longDescription"]! as String
                   
                    
                    
                    let price: Double = productDiciontary["regularPrice"]! as Double
                    
                    let imgUrl = productDiciontary["largeImage"]! as String
                    let url = NSURL(string: imgUrl)
                    let imageData = NSData(contentsOfURL: url!)
                    let image = UIImage(data: imageData!)

                    pullResult = (name: name, sku: skuString, productDesc: productDesc, price: price, imgUrl: image!)
                    bestBuyProductPullArray += [pullResult]
                    
                }
                
            }
            
        }
        return bestBuyProductPullArray
    }
    
    func saveBestBuyItemForSku (sku: String, json: NSDictionary) {
        
        if json["products"] != nil {
            let results:[AnyObject] = json["products"]! as [AnyObject]
            
            for productDictionary in results{
                
                if productDictionary["sku"] != nil && productDictionary["sku"] as String == sku {
                    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
                    
                    var requestForBestBuyProduct = NSFetchRequest(entityName: "Product")
                    
                    let productDictionarySku = productDictionary["sku"]! as String
                    
                    let predicate = NSPredicate(format: "sku == %@", productDictionarySku)
                    
                    requestForBestBuyProduct.predicate = predicate
                    
                    var error:NSError?
                    
                    var products = managedObjectContext?.executeFetchRequest(requestForBestBuyProduct, error: &error)
                    
                    if products?.count != 0 {
                        //product already in cart so do not save it again
                        
                        return
                    } else {
                        // create the entity for core data before populating it
                        println("Gonna save the product to core data")
                        let entityDescription = NSEntityDescription.entityForName("Product", inManagedObjectContext: managedObjectContext!)
                        
                        let product = Product(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
                        //start to populate the product we save to core data
                        product.sku = productDictionary["sku"]! as String
                        product.dateAdded = NSDate()
                        
                        if productDictionary["name"] != nil {
                            product.name = productDictionary["name"]! as String
                        }
                        
                        if productDictionary["regularPrice"] != nil {
                            // might need to change data type to float when integrating Stripe API
                            product.price = productDictionary["regularPrice"]! as NSNumber
                        } else {
                            product.price = 0.00
                        }
                        
                        if productDictionary["largeImage"] != nil {
                            product.imageName = productDictionary["largeImage"]! as String
                        } else {
                            product.imageName = "fillerPic.jpeg"
                        }
                        
                        if productDictionary["longDescription"] != nil {
                            product.productDescription = productDictionary["longDescription"]! as String
                        } else {
                            product.productDescription = "We could not find a description for this product"
                        }
                        
                        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
                        
                    }
                    
                }
                
            }
        
        }
        
    }
    
}
