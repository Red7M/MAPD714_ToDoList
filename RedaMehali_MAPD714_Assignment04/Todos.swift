//
//  Todos.swift
//  RedaMehali_MAPD714_Assignment04
//
//  Created by Reda Mehali on 11/30/20.
//

import UIKit

class Todos {
    
    var name: String
    var dueText: String
    var isCompleted: Bool
    
    init?(name: String, dueText: String, isCompleted: Bool) {
        // Initialization should fail if there is no title or dueDate.
//        if title.isEmpty || dueDate.isEmpty {
//            return nil
//        }
        
        self.name = name
        self.dueText = dueText
        self.isCompleted = isCompleted
    }
}
