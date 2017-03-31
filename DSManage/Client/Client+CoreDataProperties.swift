//
//  Client+CoreDataProperties.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 11/02/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var avatar: NSData?

}
