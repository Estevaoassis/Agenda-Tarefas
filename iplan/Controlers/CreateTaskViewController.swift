//
//  CreateTaskViewViewController.swift
//  iplan
//
//  Created by Aluno10 on 17/03/22.
//  Copyright © 2022 Aluno10. All rights reserved.
//

import UIKit

class CreateTaskViewController: UITableViewController, UITextFieldDelegate {
    
    private var datePicker = UIDatePicker()
    private var dateFormatter = DateFormatter()
    private var selectedIndexPath: IndexPath?
    
    private var taskRepository = TaskRepository.instance
    
    
    var task: Task = Task()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        datePicker.datePickerMode = .dateAndTime
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Task Name"
        } else if section == 1 {
            return "Category"
        } else{
            return "Date and Time"
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskDescriptionCell", for: indexPath) as! TaskDescriptionTableViewCell
            cell.taskDescriptionTextField.delegate = self
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            cell.textLabel?.text = self.task.category.name
            
            return cell
        
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateTimeTableViewCell
        cell.dateTimeTextField.inputView = datePicker
        cell.dateTimeTextField.delegate = self
        cell.dateTimeTextField.inputAccessoryView = accessoryView()
        cell.dateTimeTextField.text = dateFormatter.string(from: task.date)
        return cell
    }
    
    //MARK: Botão de save
    
    @IBAction func tapSaveButton(_ sender: Any) {
        
        //self.task.name = textField.text!
        taskRepository.save(task: task)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: UITextFieldDelegate Methods
     
    func textFieldDidEndEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? DateTimeTableViewCell
        if let dateCell = cell {
            self.selectedIndexPath = tableView.indexPath(for: dateCell)
           
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let text = textField.text ??  ""
        
        switch textField.tag {
            case 1:
                task.name = text
            default:
                return
        }
    
        //self.task.name = textField.text!
    }
    
    // MARK: - UIView Functions
    
    func accessoryView() -> UIView {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let barItemSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton  = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(selectDate))
        
        toolBar.setItems([barItemSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        return toolBar
    }
    
   
    @objc func selectDate() {
//        if let indexPath = self.selectedIndexPath {
//            let cell = tableView.cellForRow(at: indexPath) as? DateTimeTableViewCell
//            if let dateCell = cell {
             // dateTimeTextField.text = dateFormatter.string(from: datePicker.date)
                 self.view.endEditing(true)
                self.task.date = datePicker.date
            self.tableView.reloadData()
//            }
//        }
    }
    // MARK: - Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCategoriesTableViewController"{
            let categoriesController = segue.destination as! CategoriesTableViewController
            categoriesController.choosenCategory = { category in
                self.task.category = category
                self.tableView.reloadData()
                
            }
            
        }
    }
    
    
}
