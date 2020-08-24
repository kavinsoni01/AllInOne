//
//  Track+CoreDataProperties.swift
//  
//
//  Created by Kavin Soni on 24/08/20.
//
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track")
    }

    @NSManaged public var id: Int16
    @NSManaged public var albumname: String?
    @NSManaged public var trackname: String?
    @NSManaged public var status: Int16
    @NSManaged public var trackimage: Data?
    @NSManaged public var documentLink: URL?
    @NSManaged public var audioLink: String?
    @NSManaged public var imageurl: String?

}
