//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Ihor Sihuta on 10/15/18.
//  Copyright © 2018 hustlehard. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var tasks = ["strelat'", "kolotit'"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNew(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "What would you like to do?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.tasks.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Create new item"
        }
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
