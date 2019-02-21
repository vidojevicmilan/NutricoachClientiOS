//
//  NamePageBulletinItem.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/15/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import Foundation
import BLTNBoard

class NamePageBulletinItem: BLTNPageItem {
    lazy var nameField = UITextField()
    
    
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        nameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameField.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        nameField.placeholder = "Name"
        nameField.textAlignment = .center
        nameField.font = UIFont.systemFont(ofSize: 30)
        nameField.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        
        
        return [nameField]
    }
}
