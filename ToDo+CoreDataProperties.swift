//
//  ToDo+CoreDataProperties.swift
//  ToDoApp-W22
//
//  Created by Rania Arbash on 2022-04-07.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var task: String?
    @NSManaged public var date: String?

}

extension ToDo : Identifiable {

}
