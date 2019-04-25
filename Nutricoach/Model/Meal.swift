//
//  Meal.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/8/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import Foundation

class Meal {
    var title: String
    var ingreedients: [Ingreedient]
    
    init(title: String, ingreedients: [Ingreedient]){
        self.title = title
        self.ingreedients = ingreedients
    }
}

class Ingreedient {
    var id: String
    var name: String
    var amount: Int
    var unit: String
    
    init(id: String, name: String, amount: Int, unit: String){
        self.id = id
        self.name = name
        self.amount = amount
        self.unit = unit
    }
}
