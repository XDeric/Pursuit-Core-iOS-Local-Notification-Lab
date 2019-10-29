//
//  SettingViewController.swift
//  Notification
//
//  Created by EricM on 10/29/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var pickerOutlet: UIDatePicker!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBAction func create(_ sender: UIButton) {
        let item = ToDo(title: textFieldOutlet.text!, dueBy: pickerOutlet.date)
        
        do {
            try ToDoPersistenceHelper.manager.save(newToDo: item)
            MakeNotification.configureAlerts(identifier: textFieldOutlet.text!, title: textFieldOutlet.text!, body: "whatever", time: 5 /*Date().timeIntervalSince(datePicker.date)*/)
        } catch {
            fatalError()
        }
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
