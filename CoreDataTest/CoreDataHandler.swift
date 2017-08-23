//
//  CoreDataHandler.swift
//  CoreDataTest
//
//  Created by you on 2017/08/24.
//  Copyright © 2017年 you12724. All rights reserved.
//

import CoreData
import UIKit

class CoreDataHandler {
    private let context: AppDelegate
    public static let shared = CoreDataHandler()
    
    private init() {
        context = UIApplication.shared.delegate as! AppDelegate
    }
    
    func addTasks(_ name: String?) {
        let viewContext = context.persistentContainer.viewContext
        let task = Task(context: viewContext)
        task.name = name
        context.saveContext()
    }
    
    func getTasks() -> [Task]? {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return try? context.persistentContainer.viewContext.fetch(fetchRequest)
    }

    func updateTask(task: Task, name: String?) {
        task.name = name
        context.saveContext()
    }
    
    func deleteTask(task: Task) {
        context.persistentContainer.viewContext.delete(task)
        context.saveContext()
    }
}
