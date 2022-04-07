//
//  CoreDataService.swift
//  ToDoApp-W22
//
//  Created by Rania Arbash on 2022-04-07.
//

import Foundation
import CoreData


//select * from ToDo where task contains

class CoreDataService {
    static var Shared : CoreDataService = CoreDataService()
    
    
    func getAllToDo()->[ToDo] {
        // select query in SQL
        // select * from ToDo where id = '' oreder by
        //select * from ToDo : fetch request
        // select * from ToDo where id = '' : fetch request with NSPredicate
        //select * from ToDo where id = '' oreder by: fetch request with NSPredicate and sort description
        
        //creat NsFetchRequest object
        //configer the object with NsPredicate and NsSortDescription
        //excute the request in the context
        var result = [ToDo]()
        let fetchRequest = ToDo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: true)]
        
        do{
         result = try  persistentContainer.viewContext.fetch(fetchRequest) as [ToDo]
        }catch {
            print(error)
        }
        return result
    }
    
    func getToDoStartWith(text: String)->[ToDo] {
        
        var result = [ToDo]()
        let fetchRequest = ToDo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: true)]
        
        fetchRequest.predicate = NSPredicate(format: "task CONTAINS [c] %@ " ,text as CVarArg)
       
        // where id = ''
        //NSPredicate(format: "num >= %d " , 3)
        
        do{
         result = try  persistentContainer.viewContext.fetch(fetchRequest) as [ToDo]
        }catch {
            print(error)
        }
        return result
    }
    
    func insertNewToDo(t: String, d: String)  {
        
        let newToDo = ToDo(context: persistentContainer.viewContext)
        newToDo.task = t
        newToDo.date = d
        
        saveContext()
        
    }
    func updateToDo(oldToDo: ToDo, newTask: String, newDate: String)  {
        
        oldToDo.task = newTask
        oldToDo.date = newDate
        
        saveContext()
        
    }
    
    func deleteToDo(toDeleteToDo: ToDo)  {
        persistentContainer.viewContext.delete(toDeleteToDo)
        saveContext()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "ToDoApp_W22")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
