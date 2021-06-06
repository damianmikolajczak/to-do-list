//
//  PendingTasksViewController.swift
//  To-do list
//
//  Created by Damian Mikołajczak on 05/06/2021.
//

import UIKit

class PendingTasksViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pendingTasks: [Task]?
    
    @IBOutlet var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
        tasksTableView.reloadData()
    }
    
    func fetchData() {
        do {
            let allTasks:[Task] = try context.fetch(Task.fetchRequest())
            pendingTasks = allTasks.filter({ task in
                return task.status == .Pending
            })
        } catch { }
    }
}

extension PendingTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pendingTasks!.count != 0 {
            return pendingTasks!.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingTableCell", for: indexPath)
        
        switch pendingTasks?.count {
        case 0:
            cell.textLabel?.text = "No items found. Press “Add” to add new items."
        default:
            cell.textLabel?.text = pendingTasks?[indexPath.row].title
            
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            cell.textLabel?.text?.append(" - \(formatter.string(from: (pendingTasks?[indexPath.row].deadline)!))")
        }
        
        return cell
    }
    
    
}
extension PendingTasksViewController:UITableViewDelegate {
    
}
