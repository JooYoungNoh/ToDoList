//
//  ToDoListVM.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/09.
//

import Foundation

class ToDoListVM {
    var toDoList: [ToDoListModel] = []
    
    func dataPasing(_ fileName: String) {
        let data: Data
        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
        else {
            fatalError("\(fileName) not found.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Could not load \(fileName): \(error)")
        }
        
        do {
            self.toDoList = try JSONDecoder().decode([ToDoListModel].self, from: data)
        } catch {
            fatalError("Unable to parse \(fileName): \(error)")
        }
        
    }
}
