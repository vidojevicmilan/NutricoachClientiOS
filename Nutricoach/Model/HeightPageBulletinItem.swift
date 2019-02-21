//
//  HeightPageBulletinItem.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/15/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import Foundation
import BLTNBoard

class HeightPageBulletinItem: BLTNPageItem {
    lazy var heightField = UITextField()
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        heightField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        heightField.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        heightField.placeholder = "Height in cm"
        heightField.textAlignment = .center
        heightField.font = UIFont.systemFont(ofSize: 30)
        heightField.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        
        return [heightField]
    }
}
