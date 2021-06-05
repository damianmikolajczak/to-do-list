//
//  OverdueTasksViewController.swift
//  To-do list
//
//  Created by Damian Mikołajczak on 05/06/2021.
//

import UIKit

class OverdueTasksViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var overdueTasks: [Task]?
    
    @IBOutlet var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let allTasks:[Task] = try context.fetch(Task.fetchRequest())
            overdueTasks = allTasks.filter({ task in
                return task.status == .Overdue
            })
        } catch { }
        
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
    }
}

extension OverdueTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if overdueTasks!.count != 0 {
            return overdueTasks!.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverdueTableCell", for: indexPath)
        
        switch overdueTasks?.count {
        case 0:
            cell.textLabel?.text = "No items found. Press “Add” to add new items."
        default:
            if let taskTitle = overdueTasks?[indexPath.row].title {
                cell.textLabel?.text = taskTitle
            }
        }
        return cell
    }
    
    
}
extension OverdueTasksViewController:UITableViewDelegate {
    
}
