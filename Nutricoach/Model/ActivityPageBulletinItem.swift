//
//  ActivityPageBulletinItem.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/16/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import Foundation
import BLTNBoard

class ActivityPageBulletinItem: BLTNPageItem {
    
    lazy var selectedButonText = String()
    lazy var litleActive = UIButton()
    lazy var moderateActive = UIButton()
    lazy var veryActive = UIButton()
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        litleActive.setTitle("Not Very Active", for: .normal)
        litleActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        litleActive.setTitleColor(.black, for: .normal)
        litleActive.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        litleActive.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        litleActive.addTarget(self, action: #selector(litleActiveAction), for: .touchUpInside)
        
        moderateActive.setTitle("Moderately Acitve", for: .normal)
        moderateActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        moderateActive.setTitleColor(.black, for: .normal)
        moderateActive.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        moderateActive.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        moderateActive.addTarget(self, action: #selector(moderateActiveAction), for: .touchUpInside)
        
        veryActive.setTitle("Very Active", for: .normal)
        veryActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        veryActive.setTitleColor(.black, for: .normal)
        veryActive.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        veryActive.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        veryActive.addTarget(self, action: #selector(veryActiveAction), for: .touchUpInside)
        
        return [litleActive, moderateActive, veryActive]
    }
    
    @objc func litleActiveAction(sender: UIButton!){
        sender.backgroundColor = UIColor(red: 0, green: 131/255, blue: 249/255, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        moderateActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        moderateActive.setTitleColor(.black, for: .normal)
        veryActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        veryActive.setTitleColor(.black, for: .normal)
        selectedButonText = (sender.titleLabel?.text)!
    }
    
    @objc func moderateActiveAction(sender: UIButton!){
        sender.backgroundColor = UIColor(red: 0, green: 131/255, blue: 249/255, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        litleActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        litleActive.setTitleColor(.black, for: .normal)
        veryActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        veryActive.setTitleColor(.black, for: .normal)
        selectedButonText = (sender.titleLabel?.text)!
    }
    
    @objc func veryActiveAction(sender: UIButton!){
        sender.backgroundColor = UIColor(red: 0, green: 131/255, blue: 249/255, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        litleActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        litleActive.setTitleColor(.black, for: .normal)
        moderateActive.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        moderateActive.setTitleColor(.black, for: .normal)
        selectedButonText = (sender.titleLabel?.text)!
    }
    
}
