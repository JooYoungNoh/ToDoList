//
//  DetailToDoListVM.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/27.
//

import Foundation
import CoreData

class DetailToDoListViewModel {
    
    func saveListItem(container: NSPersistentContainer) {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateListItem(container: NSPersistentContainer, listItem: ToDoListModel, title: String, description: String, completed: Int) {
        let isCompleted = completed == 1 ? true : false
        
        if listItem.title != title || listItem.descriptionToDo != description || listItem.completed != isCompleted {
            listItem.title = title
            listItem.descriptionToDo = description
            listItem.completed = isCompleted
            
            saveListItem(container: container)
        }
    }
}
