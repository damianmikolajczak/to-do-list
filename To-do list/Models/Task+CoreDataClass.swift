//
//  Task+CoreDataClass.swift
//  To-do list
//
//  Created by Damian Mikołajczak on 05/06/2021.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    
    enum TaskStatus: Int16 {
        case Pending = 0
        case Completed = 1
        case Overdue = 2
    }
    
    var status: TaskStatus {
        get {
            return TaskStatus.init(rawValue: rawStatus)!
        }
        set {
            rawStatus =  newValue.rawValue
        }
    }
    
}
