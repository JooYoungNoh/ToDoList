//
//  ToDoListVM.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/09.
//

import Foundation
import CoreData

class ToDoListVM {
    let container: NSPersistentContainer
    
    var toDoList: [ToDoListModel] = []
    
    init() {
        container = NSPersistentContainer(name: "ToDoListModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("SUCCESSFULLY LOAD CORE DATA")
            }
        }
        fetchList()
    }
    
    func fetchList() {
        let request = NSFetchRequest<ToDoListModel>(entityName: "ToDoListModel")
        do {
            self.toDoList = try container.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveListItem() {
        do {
            try container.viewContext.save()
            fetchList()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addListItem(title: String, description: String) {
        let item = ToDoListModel(context: container.viewContext)
        
        if let last = self.toDoList.last {
            item.id = last.id+1
        } else {
            item.id = 1
        }
        
        item.title = title
        item.descriptionToDo = description
        item.completed = false
        
        saveListItem()
    }
}
