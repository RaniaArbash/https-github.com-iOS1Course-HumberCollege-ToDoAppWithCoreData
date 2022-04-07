//
//  ToDoTableTableViewController.swift
//  ToDoApp-W22
//
//  Created by Rania Arbash on 2022-04-07.
//

import UIKit

class ToDoTableTableViewController: UITableViewController, UISearchBarDelegate {

    var listOfToDo: [ToDo] = [ToDo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTable()
    }

    func updateTable(){
        listOfToDo = CoreDataService.Shared.getAllToDo()
        tableView.reloadData()
      
    }
    
    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return listOfToDo.count
    }

    @IBAction func addNewToDo(_ sender: Any) {
        let alert = UIAlertController.init(title: "Add New Task", message: "Enter your task describtion", preferredStyle: .alert)
              
        var textField = UITextField()
              
        alert.addTextField { (alertTextField) in
                  alertTextField.placeholder = "Enter the task here"
                  textField = alertTextField
        }
              
        let action = UIAlertAction.init(title: "Save", style: .default) { (action) in
                  // save the new task to coredata
                  
                if let correctTask = textField.text {
                    CoreDataService.Shared.insertNewToDo(t: correctTask, d: Date().description)
                    
                    self.updateTable()
                  }
              }
              
              let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
              
              alert.addAction(action)
              alert.addAction(cancelAction)
              present(alert, animated: true, completion: nil)
             
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = listOfToDo[indexPath.row].task
        cell.detailTextLabel?.text = listOfToDo[indexPath.row].date


        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController.init(title: "Update Task", message: "Update task describtion", preferredStyle: .alert)
              
        var textField = UITextField()
              
        alert.addTextField { (alertTextField) in
            alertTextField.text = self.listOfToDo[indexPath.row].task
            textField = alertTextField
        }
              
        let action = UIAlertAction.init(title: "Update", style: .default) { (action) in
                  // save the new task to coredata
                if let correctTask = textField.text {
                    CoreDataService.Shared.updateToDo(oldToDo: self.listOfToDo[indexPath.row], newTask: correctTask, newDate: Date().description)
                    
                    self.updateTable()
                  }
              }
              
              let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
              
              alert.addAction(action)
              alert.addAction(cancelAction)
              present(alert, animated: true, completion: nil)
         
        
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count == 0{
            updateTable()
        }else {
        listOfToDo = CoreDataService.Shared.getToDoStartWith(text: searchText)
        tableView.reloadData()
        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure you want to delete this task??", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                CoreDataService.Shared.deleteToDo(toDeleteToDo: self.listOfToDo[indexPath.row])
                self.updateTable()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)

        }
    }
    

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

}
