//
//  AddTaskViewController.swift
//  CoreToDo for Qiita
//
//  Created by Masaya Hayashi on 2017/01/28.
//  Copyright © 2017年 Masaya Hayashi. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var categoryTextField: UITextField!
    
    // MARK: -
    
    var taskCategory = "ToDo"
    
    // MARK: -
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var task: Task?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add segment of added categories into categorySegmentedControl
        if taskCategories.count > firstNumberOfTaskCategories {
            for addedCategoryIndex in firstNumberOfTaskCategories..<taskCategories.count {
                categorySegmentedControl.insertSegment(withTitle: taskCategories[addedCategoryIndex], at: addedCategoryIndex, animated: false)
            }
        }
        
        // set information of selected task (got from segue)
        if let task = task {
            taskTextField.text = task.name
            taskCategory = task.category!
            if let taskCategoryIndex = taskCategories.index(of: task.category!) {
                categorySegmentedControl.selectedSegmentIndex = taskCategoryIndex
            } else {
                categorySegmentedControl.selectedSegmentIndex = 0
            }
        }
    }
    
    // MARK: - Actions of Buttons
    
    @IBAction func categoryChosen(_ sender: UISegmentedControl) {
        // choose category of task
        taskCategory = taskCategories[sender.selectedSegmentIndex]
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        
        let taskName = taskTextField.text
        if taskName == "" {
            dismiss(animated: true, completion: nil)
            return
        }
        
        if task == nil {
            task = Task(context: context)
        }
        
        if let task = task {
            task.name = taskName
            task.category = taskCategory
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewCategory(_ sender: Any) {
        // dismiss if no category is input
        let newCategory = categoryTextField.text
        if newCategory == "" {
            dismiss(animated: true, completion: nil)
            return
        }
        
        // add new category into core data
        let addedCategory = AddedCategory(context: context)
        addedCategory.category = newCategory!
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: nil)
    }
    
}
