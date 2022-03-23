//
//  Task.swift
//  iplan
//
//  Created by Aluno10 on 15/03/22.
//  Copyright © 2022 Aluno10. All rights reserved.
//

import Foundation
struct Task {
    var id = UUID()
    var name: String = ""
    var date: Date = Date()
    var category: Category =  Category(name: "Marketing", color: .black)
}
