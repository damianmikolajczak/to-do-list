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
            overdueTasks = allTasks.filter({ task in
                return task.status == .Overdue
            })
        } catch { }
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
            cell.textLabel?.text = overdueTasks?[indexPath.row].title
            
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            cell.textLabel?.text?.append(" - \(formatter.string(from: (overdueTasks?[indexPath.row].deadline)!))")
        }
        return cell
    }
}
extension OverdueTasksViewController:UITableViewDelegate {
    
}
