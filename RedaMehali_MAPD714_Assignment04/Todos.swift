//
//  Todos.swift
//  RedaMehali_MAPD714_Assignment04
//
//  Created by Reda Mehali on 11/30/20.
//

import UIKit

class Todos {
    
    var title: String
    var dueDate: String
    var state: Bool
    
    init?(title: String, dueDate: String, state: Bool) {
        // Initialization should fail if there is no title or dueDate.
        if title.isEmpty || dueDate.isEmpty {
            return nil
        }
        
        self.title = title
        self.dueDate = dueDate
        self.state = state
    }
}
