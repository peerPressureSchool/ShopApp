//
//  Product.swift
//  ShopApp
//
//  Created by Jared Mermey on 2/17/15.
//  Copyright (c) 2015 Jared Mermey. All rights reserved.
//

import Foundation
import CoreData

@objc(Product)
class Product: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var price: NSNumber
    @NSManaged var productDescription: String
    @NSManaged var imageName: String
    @NSManaged var sku: String
    @NSManaged var dateAdded: NSDate

}
