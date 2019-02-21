//
//  GoalPageBulletinItem.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/15/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import Foundation
import BLTNBoard

class GoalsPageBulletinItem: BLTNPageItem {
    
    lazy var selectedButonText = String()
    lazy var loseWeight = UIButton()
    lazy var gainMuscle = UIButton()
    lazy var maintainHealth = UIButton()
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        loseWeight.setTitle("Lose Weight", for: .normal)
        loseWeight.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        loseWeight.setTitleColor(.black, for: .normal)
        loseWeight.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        loseWeight.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        loseWeight.addTarget(self, action: #selector(loseWeightAction), for: .touchUpInside)
        
        gainMuscle.setTitle("Gain Muscle", for: .normal)
        gainMuscle.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        gainMuscle.setTitleColor(.black, for: .normal)
        gainMuscle.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        gainMuscle.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        gainMuscle.addTarget(self, action: #selector(gainMuscleAction), for: .touchUpInside)
        
        maintainHealth.setTitle("Maintain Health", for: .normal)
        maintainHealth.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        maintainHealth.setTitleColor(.black, for: .normal)
        maintainHealth.layer.cornerRadius = actionButton?.layer.cornerRadius ?? 10
        maintainHealth.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        maintainHealth.addTarget(self, action: #selector(maintainHealthAction), for: .touchUpInside)
        
        return [loseWeight, gainMuscle, maintainHealth]
    }
    
    @objc func loseWeightAction(sender: UIButton!){
        sender.backgroundColor = UIColor(red: 0, green: 131/255, blue: 249/255, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        gainMuscle.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        gainMuscle.setTitleColor(.black, for: .normal)
        maintainHealth.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        maintainHealth.setTitleColor(.black, for: .normal)
        selectedButonText = (sender.titleLabel?.text)!
    }
    
    @objc func gainMuscleAction(sender: UIButton!){
        sender.backgroundColor = UIColor(red: 0, green: 131/255, blue: 249/255, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        loseWeight.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        loseWeight.setTitleColor(.black, for: .normal)
        maintainHealth.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        maintainHealth.setTitleColor(.black, for: .normal)
        selectedButonText = (sender.titleLabel?.text)!
    }
    
    @objc func maintainHealthAction(sender: UIButton!){
        sender.backgroundColor = UIColor(red: 0, green: 131/255, blue: 249/255, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        loseWeight.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        loseWeight.setTitleColor(.black, for: .normal)
        gainMuscle.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        gainMuscle.setTitleColor(.black, for: .normal)
        selectedButonText = (sender.titleLabel?.text)!
    }
    
}
