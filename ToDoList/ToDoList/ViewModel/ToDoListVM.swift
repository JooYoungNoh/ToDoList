//
//  ToDoListVM.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/09.
//

import Foundation

class ToDoListVM {
    var toDoList: [ToDoListModel] = []
    
    func dataPasing(_ fileName: String) -> [ToDoListModel] {
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
            return try JSONDecoder().decode([ToDoListModel].self, from: data)
        } catch {
            print("왜")
            fatalError("Unable to parse \(fileName): \(error)")
        }
        
    }
}
