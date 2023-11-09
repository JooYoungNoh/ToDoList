//
//  ToDoListModel.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/09.
//

import Foundation

struct ToDoListModel: Codable {
    var id: Int
    var title: String
    var description: String
    var completed: Bool
}
