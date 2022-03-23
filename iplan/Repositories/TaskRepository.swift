//
//  TaskRepository.swift
//  iplan
//
//  Created by Aluno10 on 21/03/22.
//  Copyright © 2022 Aluno10. All rights reserved.
//

import Foundation

class TaskRepository {
    static let instance: TaskRepository = TaskRepository()
    
   private var tasks: [Task]
    
    private init() {
        self.tasks = []
        
    }
    
    func save(task: Task) {
        self.tasks.append(task)
        print(task)
    }
    
    func update(taskToUpdate: Task){
        
     let taskIndex = tasks.firstIndex { (task) -> Bool in
          task.id == taskToUpdate.id
        }
        tasks.remove(at: taskIndex!)
        tasks.append(taskToUpdate)
    }
    
    func getTasks() -> [Task]{
        self.tasks
        
    }
}
