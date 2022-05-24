//
//  ToDo.swift
//  ToDoList
//
//  Created by Sam Hiatt  on 11/8/21.
//

import UIKit
struct ToDo: Equatable, Codable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
        
       
    }()
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveUrl = documentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    static func loadToDos() -> [ToDo]? {
        guard let codedTodos = try? Data(contentsOf: archiveUrl) else {return nil }
        let propertListDecoder = PropertyListDecoder()
        return try? propertListDecoder.decode(Array<ToDo>.self, from: codedTodos)
    }
    static func saveTodos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedTodos = try?  propertyListEncoder.encode(todos)
        try? codedTodos?.write(to: archiveUrl, options: .noFileProtection)
    }
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
    static func loadSampleToDocs() -> [ToDo] {
        let todo1 = ToDo(title: "To do 1", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "To do 2", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "To do 3", isComplete: false, dueDate: Date(), notes: "Notes 3")
        return [todo1, todo2, todo3]
    }
    
    
    
}
