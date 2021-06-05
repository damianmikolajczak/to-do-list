//
//  Task+CoreDataProperties.swift
//  To-do list
//
//  Created by Damian Mikołajczak on 05/06/2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var detail: String?
    @NSManaged public var deadline: Date?
    @NSManaged public var rawStatus: Int16

}

extension Task : Identifiable {

}
