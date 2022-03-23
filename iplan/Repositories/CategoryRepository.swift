//
//  CategoryRepository.swift
//  iplan
//
//  Created by Aluno10 on 20/03/22.
//  Copyright © 2022 Aluno10. All rights reserved.
//

import Foundation
import UIKit

class CategoryRepository {
    static func getCategories() -> [Category] {
        let categories = [
            Category(name:"Trabalho", color: UIColor.green),
            Category(name:"Estudos", color: UIColor.blue),
            Category(name:"Academia", color: UIColor.yellow),
            Category(name:"Lembretes", color: UIColor.red),
            ]
        
    return categories;

    }

}



