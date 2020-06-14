//
//  Ticket+CoreDataProperties.swift
//  Smart Doc
//
//  Created by 17790204 on 14/06/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//
//

import Foundation
import CoreData


extension Ticket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ticket> {
        return NSFetchRequest<Ticket>(entityName: "Ticket")
    }

    @NSManaged public var date: String?
    @NSManaged public var specialitie: String?
    @NSManaged public var polyclinic: String?

}
