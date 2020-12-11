//
//  ToDoItemTableViewController.swift
//  RedaMehali_MAPD714_Assignment04
//
//  Created by Reda Mehali on 11/30/20.
//

import UIKit
import CoreData

class ToDoItemTableViewController: UITableViewController {
    
    // MARK: - Table view data source
    var todos = [Todos]()
    var rowPosition = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data
        loadSampleToDos()
    }
    @IBAction func todoSwitchClick(_ uiSwitch: UISwitch) {}
    
    @IBAction func addToDoItem(_ sender: UIBarButtonItem) {
        // show input dialog
        showTodoInputDialog()
    }
    
    @IBAction func editToDoClick(_ todoEdit: UIButton) {
        print(todoEdit.tag)
        rowPosition = todoEdit.tag
        performSegue(withIdentifier: "rowPosition", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ToDoDetailsViewController
        vc.rowPosition = self.rowPosition
    }
    
    
    func showTodoInputDialog() {
        let alertController = UIAlertController(title: "Enter todo name, and due text", message: nil, preferredStyle: .alert)
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let name = alertController.textFields?[0].text
            let due = alertController.textFields?[1].text
            
            guard let todo = Todos(name: name!,dueText: due!, isCompleted: false) else {
                fatalError("Unable to instantiate todo")
            }
            self.todos.append(todo)
            self.updateTableView()
        }
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter todo name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter todo due text"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateTableView() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: todos.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ToDoItemTableViewCell"
        guard let cell = super.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ToDoItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of ToDoItemTableViewCell.")
        }
        
        let todo = todos[indexPath.row]
        
        cell.toDoItemTitleText.text = todo.name
        cell.toDoItemDueText.text = todo.dueText
        cell.toDoItemSwitchState.isOn = todo.isCompleted
        cell.todoEdit.tag = indexPath.row
        
        return cell
    }
    
    private func loadSampleToDos() {
        guard let todo1 = Todos(name: "Do laundry (washing and drying)",dueText: "coming weekend", isCompleted: false) else {
            fatalError("Unable to instantiate todo1")
        }
        
        guard let todo2 = Todos(name: "Changing TV remote batteries",dueText: "overdue!", isCompleted: false) else {
            fatalError("Unable to instantiate todo2")
        }
        
        guard let todo3 = Todos(name: "Cleaning swimming pool",dueText: "completed", isCompleted: true) else {
            fatalError("Unable to instantiate todo3")
        }
        
        // Delete any available Data
        deleteAllTodoCoreData()
        
        // Save data
        self.saveToDos(name: todo1.name, isCompleted: todo1.isCompleted, notes: todo1.dueText, hasDueDate: false, dueDate: Date())
        self.saveToDos(name: todo2.name, isCompleted: todo2.isCompleted, notes: todo2.dueText, hasDueDate: false, dueDate: Date())
        self.saveToDos(name: todo3.name, isCompleted: todo3.isCompleted, notes: todo3.dueText, hasDueDate: false, dueDate: Date())
        // Retrieve Data
        //        self.retrieveToDos()
        
        todos += [todo1, todo2, todo3]
    }
}

extension UITableViewController {
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
    
    func retrieveToDos() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    if let name = result.name {
                        print("Todo name is: \(name)")
                    }
                    
                    print("is Todo completed?: \(String(result.isCompleted))")
                    
                    if let notes = result.notes {
                        print("Todo notes are: \(notes)")
                    }
                    
                    print("Does Todo have due date?: \(String(result.hasDueDate))")
                    
                    if let dueDate = result.dueDate {
                        print("Todo due dates are: \(dueDate)")
                    }
                    print("**********************************")
                }
            } catch {
                print("Could not retrieve...")
            }
        }
    }
    
    func deleteAllTodoCoreData() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntity")
            
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                for object in results {
                    guard let objectData = object as? NSManagedObject else {continue}
                    context.delete(objectData)
                }
            } catch let error {
                print("Detele all data in 'ToDoEntity' error :", error)
            }
        }
    }
}
