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
    var name: String
    var amount: Int
    
    init(name: String, amount: Int){
        self.name = name
        self.amount = amount
    }
}
