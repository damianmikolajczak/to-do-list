//
//  CompletedTasksViewController.swift
//  To-do list
//
//  Created by Damian Mikołajczak on 05/06/2021.
//

import UIKit

class CompletedTasksViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var completedTasks: [Task]?
    
    @IBOutlet var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let allTasks:[Task] = try context.fetch(Task.fetchRequest())
            completedTasks = allTasks.filter({ task in
                return task.status == .Completed
            })
        } catch { }
        
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
    }
}

extension CompletedTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if completedTasks!.count != 0 {
            return completedTasks!.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTableCell", for: indexPath)

        switch completedTasks?.count {
        case 0:
            cell.textLabel?.text = "No items found. Press “Add” to add new items."
        default:
            if let taskTitle = completedTasks?[indexPath.row].title {
                cell.textLabel?.text = taskTitle
            }
        }
        return cell
    }
    
    
}
extension CompletedTasksViewController:UITableViewDelegate {
    
}
