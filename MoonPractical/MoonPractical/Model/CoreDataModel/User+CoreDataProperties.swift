//
//  User+CoreDataProperties.swift
//  
//
//  Created by Kavin Soni on 21/08/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var fullname: String?
    @NSManaged public var address: String?
    @NSManaged public var dob: String?
    @NSManaged public var designation: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: Int16
    @NSManaged public var phone: String?
    @NSManaged public var profile_pic: String?
    @NSManaged public var salary: String?
    @NSManaged public var createdate: String?
    @NSManaged public var updatedat: String?
    @NSManaged public var email: String?

}
