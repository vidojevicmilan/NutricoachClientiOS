//
//  AgePageBulletinItem.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/15/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import Foundation
import BLTNBoard

class AgePageBulletinItem: BLTNPageItem {
    lazy var ageField = UITextField()
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        ageField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ageField.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        ageField.placeholder = "Age"
        ageField.textAlignment = .center
        ageField.font = UIFont.systemFont(ofSize: 30)
        ageField.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        
        return [ageField]
    }
}
