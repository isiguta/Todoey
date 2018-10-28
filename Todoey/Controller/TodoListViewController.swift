//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Ihor Sihuta on 10/15/18.
//  Copyright © 2018 hustlehard. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var tasks = [Task]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTasks()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        cell.accessoryType = task.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        task.done = !task.done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "What would you like to do?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let task = Task(context: self.context)
            task.title = textField.text!
            task.done = false
            
            self.tasks.append(task)
            self.save()
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Create new item"
        }
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func loadTasks(with request:NSFetchRequest<Task> = Task.fetchRequest()) {
        do {
            tasks = try context.fetch(request)
            print(tasks)
        } catch {
            print("THERE'S AN ERROR READING DATA \(error)")
        }
        
        tableView.reloadData()
    }
    
}

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadTasks(with: request)
    }
    
}
