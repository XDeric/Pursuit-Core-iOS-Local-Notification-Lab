//
//  ViewController.swift
//  Notification
//
//  Created by EricM on 10/29/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var toDos = [ToDo]() {
        didSet {
            tableViewOutlet.reloadData()
        }
    }
    @IBOutlet weak var tableViewOutlet: UITableView!
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    private func loadData() {
        if try! ToDoPersistenceHelper.manager.getPersistedToDos().count < 1 {
            toDos = ToDo.getDefaultTodos()
            
        }else {
            toDos = try! ToDoPersistenceHelper.manager.getPersistedToDos()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDos.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            center.removePendingNotificationRequests(withIdentifiers: [toDos[indexPath.row].title])
            toDos.remove(at: indexPath.row)
            do {
                try ToDoPersistenceHelper.manager.deleteToDo(title: toDos[indexPath.row].title)
            } catch {
                print(error)
            }
            tableViewOutlet.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDo = toDos[indexPath.row]
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = toDo.title
        let labelSettings = getLabelSettings(from: toDo.dueBy)
        cell.detailTextLabel?.text = labelSettings.0
        cell.detailTextLabel?.textColor = labelSettings.1
        return cell
    }
    
    private func getLabelSettings(from date: Date) -> (String,UIColor) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let dateString = dateFormatter.string(from: date)
        if date >= Date() {
            return (dateString, .red)
        } else {
            return (dateString, .gray)
        }
    }
    
    
}

