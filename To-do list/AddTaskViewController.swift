//
//  AddTaskViewController.swift
//  To-do list
//
//  Created by Damian Mikołajczak on 05/06/2021.
//

import UIKit

class AddTaskViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let notificationManager = LocalNotificationManager()
    
    @IBOutlet var taskTitle: UITextField!
    @IBOutlet var taskDescription: UITextField!
    @IBOutlet var taskDeadline: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.placeholder = "Title"
        taskDescription.placeholder = "A short description"
        HideKeyboard()
        notificationManager.requestForAuthorization()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancleView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTask() {
        if taskDeadline.date.timeIntervalSinceNow > 0 {
            
            let newTask = Task(context: context)
            newTask.title = taskTitle.text
            newTask.detail = taskDescription.text
            newTask.deadline = taskDeadline.date
            newTask.status = .Pending
            
            do {
                try context.save()
                notificationManager.addLocalNotification(categoryIdentifier: "Tasks", title: newTask.title!, body: newTask.detail!, date: newTask.deadline!)
            } catch { }
            
            self.dismiss(animated: true, completion: nil)
            
        } else {
            
        }
    }

}

extension AddTaskViewController {
    
    func HideKeyboard () {
        let tap = UIGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
