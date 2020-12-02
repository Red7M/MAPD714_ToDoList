//
//  ToDoItemTableViewController.swift
//  RedaMehali_MAPD714_Assignment04
//
//  Created by Reda Mehali on 11/30/20.
//

import UIKit

class ToDoItemTableViewController: UITableViewController {
    
    // MARK: - Table view data source
    var todos = [Todos]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data
        loadSampleToDos()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ToDoItemTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ToDoItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of ToDoItemTableViewCell.")
        }
        
        let todo = todos[indexPath.row]
        
        cell.toDoItemTitleText.text = todo.title
        cell.toDoItemDueText.text = todo.dueDate
        cell.toDoItemSwitchState.isOn = todo.state
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func loadSampleToDos() {
        guard let todo1 = Todos(title: "Do laundry (washing and drying)",dueDate: "coming weekend", state: false) else {
            fatalError("Unable to instantiate todo1")
        }
        
        guard let todo2 = Todos(title: "Changing TV remote batteries",dueDate: "overdue!", state: false) else {
            fatalError("Unable to instantiate todo2")
        }
        
        guard let todo3 = Todos(title: "Cleaning swimming pool",dueDate: "completed", state: true) else {
            fatalError("Unable to instantiate todo3")
        }
        
        todos += [todo1, todo2, todo3]
    }

}
