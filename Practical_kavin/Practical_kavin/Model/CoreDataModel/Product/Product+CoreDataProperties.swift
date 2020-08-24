//
//  Product+CoreDataProperties.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 23/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var image1: Data?
    @NSManaged public var category: String?
    @NSManaged public var qty: String?
    @NSManaged public var company: String?
    @NSManaged public var productdescription: String?
    @NSManaged public var price: String?
    @NSManaged public var image2: Data?
    @NSManaged public var image3: Data?
    @NSManaged public var image4: Data?
    @NSManaged public var id: Int16

}
