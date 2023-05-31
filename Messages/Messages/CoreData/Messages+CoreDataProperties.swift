//
//  Messages+CoreDataProperties.swift
//  Messages
//
//  Created by Александр Головин on 31.05.2023.
//
//

import Foundation
import CoreData


extension Messages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Messages> {
        return NSFetchRequest<Messages>(entityName: "Messages")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension Messages : Identifiable {

}
