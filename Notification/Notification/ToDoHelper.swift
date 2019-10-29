//
//  ToDoHelper.swift
//  Notification
//
//  Created by EricM on 10/29/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

struct ToDoPersistenceHelper {
    static let manager = ToDoPersistenceHelper()
    
    func save(newToDo: ToDo) throws {
        try persistenceHelper.save(newElement: newToDo)
    }
    
    func getPersistedToDos() throws -> [ToDo] {
        return try persistenceHelper.getObjects()
    }
    
    func deleteToDo(title: String) throws {
        do {
            let toDos = try getPersistedToDos()
            let newToDos = toDos.filter { $0.title != title}
            try persistenceHelper.replace(elements: newToDos)
        }
    }
    
    func isDuplicate(selectedTitle: String) throws -> Bool{
        let everyToDo = try persistenceHelper.getObjects()
        if everyToDo.contains(where: { (toDo) -> Bool in
            toDo.title.lowercased() == selectedTitle.lowercased()
        }){
            return true
        }
        return false
    }
    
    private let persistenceHelper = PersistenceHelper<ToDo>(fileName: "todos.plist")
    
    private init() {}
}
