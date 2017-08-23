//
//  ViewController.swift
//  CoreDataTest
//
//  Created by you on 2017/08/23.
//  Copyright © 2017年 you12724. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var tasks: [Task]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = CoreDataHandler.shared.getTasks()
        titleLabel.text = UserDefaults.standard.string(forKey: "name")
    }

    @IBAction func tapButton(_ sender: Any) {
        let alert = UIAlertController(title: "TODO", message: "TODOを入力してください。", preferredStyle: .alert)
        let action = UIAlertAction(title: "CoreDate", style: .default) { [weak self] _ in
            CoreDataHandler.shared.addTasks(alert.textFields?[0].text)
            self?.tasks = CoreDataHandler.shared.getTasks()
            self?.tableView.reloadData()
        }
        let action2 = UIAlertAction(title: "UserDefault", style: .default) { [weak self] _ in
            self?.addUD(alert.textFields?.first?.text)
            self?.titleLabel.text = alert.textFields?.first?.text
        }
        alert.addTextField(configurationHandler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
        
    func addUD(_ name: String?) {
        UserDefaults.standard.set(name, forKey: "name")
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tasks?[indexPath.row].name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let task = tasks?[indexPath.row] else { return }
        let alert = UIAlertController(title: "編集", message: "テキストを入力", preferredStyle: .alert)
        let action = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            CoreDataHandler.shared.updateTask(task: task, name: alert.textFields?.first?.text)
            self?.tableView.reloadData()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        let action3 = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            CoreDataHandler.shared.deleteTask(task: task)
            self?.tableView.reloadData()
        }
        alert.addTextField(configurationHandler: nil)
        alert.addAction(action3)
        alert.addAction(action2)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
