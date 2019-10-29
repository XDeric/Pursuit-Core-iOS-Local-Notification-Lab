//
//  ToDo.swift
//  Notification
//
//  Created by EricM on 10/29/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation

struct ToDo: Codable {
    let title: String
    let dueBy: Date
    
    static func getDefaultTodos() -> [ToDo] {
        return [ToDo(title: "This is due in two minutes", dueBy: Date().advanced(by: 2 * 60)), ToDo(title: "This is due in five minutes", dueBy: Date().advanced(by: 5 * 60))]
    }
}
