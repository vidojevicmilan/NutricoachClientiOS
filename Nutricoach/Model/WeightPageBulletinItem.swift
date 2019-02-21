//
//  WeightPageBulletinItem.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/15/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import Foundation
import BLTNBoard

class WeightPageBulletinItem: BLTNPageItem {
    lazy var weightField = UITextField()
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        weightField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        weightField.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        weightField.placeholder = "Weight in kgs"
        weightField.textAlignment = .center
        weightField.font = UIFont.systemFont(ofSize: 30)
        weightField.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        return [weightField]
    }
}
