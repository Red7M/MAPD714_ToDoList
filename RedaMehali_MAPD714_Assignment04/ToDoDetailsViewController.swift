//
//  ToDoDetailsViewController.swift
//  RedaMehali_MAPD714_Assignment04
//
//  Created by Reda Mehali on 12/10/20.
//

import UIKit
import CoreData

class ToDoDetailsViewController : UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var todoDesc: UITextField!
    @IBOutlet weak var hasDueDate: UISwitch!
    @IBOutlet weak var isCompleted: UISwitch!
    
    var rowPosition = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveToDos(position: rowPosition, name: name, todoDesc: todoDesc, hasDueDate: hasDueDate, isCompleted: isCompleted)
    }
    
    
    @IBAction func updateToDoItem(_ sender: UIButton) {
        
    }
}

extension UIViewController {
    func retrieveToDos(position: Int, name: UITextField, todoDesc: UITextField, hasDueDate: UISwitch, isCompleted: UISwitch) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                let result = results[position]
                if let nameR = result.name {
                    name.text = nameR
                    print("Todo name is: \(nameR)")
                }
                
                isCompleted.isOn = result.isCompleted
                print("is Todo completed?: \(String(result.isCompleted))")
                
                if let notes = result.notes {
                    todoDesc.text = notes
                    print("Todo notes are: \(notes)")
                }
                
                hasDueDate.isOn = result.hasDueDate
                print("Does Todo have due date?: \(String(result.hasDueDate))")
                
                if let dueDate = result.dueDate {
                    print("Todo due dates are: \(dueDate)")
                }
                print("**********************************")
            } catch {
                print("Could not retrieve...")
            }
        }
    }
    
    func saveToDos(name: String, isCompleted: Bool, notes: String, hasDueDate: Bool, dueDate: Date) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "ToDoEntity", in: context) else {return}
            
            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
            newValue.setValue(name, forKey: "name")
            newValue.setValue(isCompleted, forKey: "isCompleted")
            newValue.setValue(notes, forKey: "notes")
            newValue.setValue(hasDueDate, forKey: "hasDueDate")
            newValue.setValue(dueDate, forKey: "dueDate")
            
            do {
                try context.save()
                print("Saved values: todo: \(name), todo completed: \(isCompleted), notes are: \(notes), has due date: \(hasDueDate), due date is: \(dueDate)")
            } catch {
                print("There was a problem while trying to save")
            }
        }
    }
}
