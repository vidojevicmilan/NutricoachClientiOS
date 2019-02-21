//
//  MealViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/9/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import UIKit

class
MealViewController: UIViewController {

    var meal : Meal?
    var ingViews = [UIView]()
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("MEAL VC")
        initIngreedientsScrollView()
    }
    
    func initIngreedientsScrollView(){
        let ingsScrollView = UIScrollView()
        containerView.addSubview(ingsScrollView)
        
        ingsScrollView.translatesAutoresizingMaskIntoConstraints = false
        ingsScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        ingsScrollView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        ingsScrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        ingsScrollView.backgroundColor = UIColor.clear
        
        let titleLabel = UILabel()
        ingsScrollView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: ingsScrollView.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: ingsScrollView.centerXAnchor).isActive = true
        titleLabel.text = meal?.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let flame = UIImageView()
        ingsScrollView.addSubview(flame)
        flame.translatesAutoresizingMaskIntoConstraints = false
        flame.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        flame.centerXAnchor.constraint(equalTo: ingsScrollView.centerXAnchor).isActive = true
        flame.widthAnchor.constraint(equalToConstant: 50).isActive = true
        flame.heightAnchor.constraint(equalToConstant: 50).isActive = true
        flame.image = UIImage(named: "flame.png")
        
        let kcal = UILabel()
        ingsScrollView.addSubview(kcal)
        kcal.translatesAutoresizingMaskIntoConstraints = false
        kcal.topAnchor.constraint(equalTo: flame.bottomAnchor, constant: 6).isActive = true
        kcal.centerXAnchor.constraint(equalTo: ingsScrollView.centerXAnchor).isActive = true
        kcal.text = "568 kcal"
        kcal.font = UIFont.systemFont(ofSize: 20)
        
        let macrosView = UIView()
        ingsScrollView.addSubview(macrosView)
        macrosView.translatesAutoresizingMaskIntoConstraints = false
        macrosView.widthAnchor.constraint(equalTo: ingsScrollView.widthAnchor).isActive = true
        macrosView.topAnchor.constraint(equalTo: kcal.bottomAnchor, constant: 6).isActive = true
        macrosView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let protein = UILabel()
        macrosView.addSubview(protein)
        protein.translatesAutoresizingMaskIntoConstraints = false
        protein.leadingAnchor.constraint(equalTo: macrosView.leadingAnchor).isActive = true
        protein.centerYAnchor.constraint(equalTo: macrosView.centerYAnchor).isActive = true
        protein.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3.0).isActive = true
        protein.textAlignment = .center
        protein.textColor = UIColor(red: 0.8627, green: 0.2784, blue: 0.5059, alpha: 1.0)
        protein.text = "Protein\n42g"
        protein.numberOfLines = 2
        
        let carbs = UILabel()
        macrosView.addSubview(carbs)
        carbs.translatesAutoresizingMaskIntoConstraints = false
        carbs.leadingAnchor.constraint(equalTo: protein.trailingAnchor).isActive = true
        carbs.centerYAnchor.constraint(equalTo: macrosView.centerYAnchor).isActive = true
        carbs.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3.0).isActive = true
        carbs.textAlignment = .center
        carbs.textColor = UIColor(red: 0.9725, green: 0.6745, blue: 0.2627, alpha: 1.0)
        carbs.text = "Carbs\n63g"
        carbs.numberOfLines = 2
        
        let fats = UILabel()
        macrosView.addSubview(fats)
        fats.translatesAutoresizingMaskIntoConstraints = false
        fats.leadingAnchor.constraint(equalTo: carbs.trailingAnchor).isActive = true
        fats.centerYAnchor.constraint(equalTo: macrosView.centerYAnchor).isActive = true
        fats.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3.0).isActive = true
        fats.textAlignment = .center
        fats.textColor = UIColor(red: 0.2627, green: 0.6157, blue: 0.9137, alpha: 1.0)
        fats.text = "Fats\n25g"
        fats.numberOfLines = 2
        
        let plate = UIImageView()
        ingsScrollView.addSubview(plate)
        plate.translatesAutoresizingMaskIntoConstraints = false
        plate.topAnchor.constraint(equalTo: macrosView.bottomAnchor, constant: 10).isActive = true
        plate.centerXAnchor.constraint(equalTo: ingsScrollView.centerXAnchor).isActive = true
        plate.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.9).isActive = true
        plate.heightAnchor.constraint(equalToConstant: self.view.frame.width*0.9).isActive = true
        plate.image = UIImage(named: "plate")
        
        for i in 0...(meal?.ingreedients.count)! - 1{
            let ingView = UIView()
            ingViews.append(ingView)
            ingView.translatesAutoresizingMaskIntoConstraints = false
            ingsScrollView.addSubview(ingView)
            
            if i == 0 {
                ingView.topAnchor.constraint(equalTo: plate.bottomAnchor, constant:6).isActive = true
            } else {
                ingView.topAnchor.constraint(equalTo: ingViews[i-1].bottomAnchor, constant: 6).isActive = true
            }
            ingView.leadingAnchor.constraint(equalTo: ingsScrollView.leadingAnchor, constant: 6).isActive = true
            ingView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 12).isActive = true
            ingView.layer.cornerRadius = 10
            ingView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.7)
            ingView.tag = i
            
            ingView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            let nameLab = UILabel()
            nameLab.translatesAutoresizingMaskIntoConstraints = false
            ingView.addSubview(nameLab)
            nameLab.topAnchor.constraint(equalTo: ingView.topAnchor, constant: 3).isActive = true
            nameLab.leadingAnchor.constraint(equalTo: ingView.leadingAnchor, constant: 6).isActive = true
            nameLab.text = meal?.ingreedients[i].name
            
            let amountLab = UILabel()
            amountLab.translatesAutoresizingMaskIntoConstraints = false
            ingView.addSubview(amountLab)
            amountLab.topAnchor.constraint(equalTo: ingView.topAnchor, constant: 3).isActive = true
            amountLab.trailingAnchor.constraint(equalTo: ingView.trailingAnchor, constant: -6).isActive = true
            amountLab.text = "\((meal?.ingreedients[i].amount)!)"
            
            let proLab = UILabel()
            proLab.translatesAutoresizingMaskIntoConstraints = false
            ingView.addSubview(proLab)
            proLab.bottomAnchor.constraint(equalTo: ingView.bottomAnchor, constant: -6).isActive = true
            proLab.leadingAnchor.constraint(equalTo: ingView.leadingAnchor, constant: 3).isActive = true
            proLab.widthAnchor.constraint(equalToConstant: (self.view.frame.width-12)/4).isActive = true
            proLab.text = "Pro: xxg"
            proLab.font = UIFont.systemFont(ofSize: 14)
            proLab.textAlignment = .center
            
            let carbLab = UILabel()
            carbLab.translatesAutoresizingMaskIntoConstraints = false
            ingView.addSubview(carbLab)
            carbLab.bottomAnchor.constraint(equalTo: ingView.bottomAnchor, constant: -6).isActive = true
            carbLab.leadingAnchor.constraint(equalTo: proLab.trailingAnchor).isActive = true
            carbLab.widthAnchor.constraint(equalToConstant: (self.view.frame.width-12)/4).isActive = true
            carbLab.text = "Carbs: xxg"
            carbLab.font = UIFont.systemFont(ofSize: 14)
            carbLab.textAlignment = .center
            
            let fatLab = UILabel()
            fatLab.translatesAutoresizingMaskIntoConstraints = false
            ingView.addSubview(fatLab)
            fatLab.bottomAnchor.constraint(equalTo: ingView.bottomAnchor, constant: -6).isActive = true
            fatLab.leadingAnchor.constraint(equalTo: carbLab.trailingAnchor).isActive = true
            fatLab.widthAnchor.constraint(equalToConstant: (self.view.frame.width-12)/4).isActive = true
            fatLab.text = "Fat: xxg"
            fatLab.font = UIFont.systemFont(ofSize: 14)
            fatLab.textAlignment = .center
            
            let kcalLab = UILabel()
            kcalLab.translatesAutoresizingMaskIntoConstraints = false
            ingView.addSubview(kcalLab)
            kcalLab.bottomAnchor.constraint(equalTo: ingView.bottomAnchor, constant: -6).isActive = true
            kcalLab.leadingAnchor.constraint(equalTo: fatLab.trailingAnchor).isActive = true
            kcalLab.widthAnchor.constraint(equalToConstant: (self.view.frame.width-12)/4).isActive = true
            kcalLab.text = "kcal: xx"
            kcalLab.font = UIFont.systemFont(ofSize: 14)
            kcalLab.textAlignment = .center
        }
        
        let chickImg = UIImage(named: "chicken")
        var aspect = chickImg!.size.width/chickImg!.size.height
        let chicken = UIImageView()
        ingsScrollView.addSubview(chicken)
        chicken.translatesAutoresizingMaskIntoConstraints = false
        chicken.trailingAnchor.constraint(equalTo: plate.centerXAnchor, constant: -5).isActive = true
        chicken.bottomAnchor.constraint(equalTo: plate.centerYAnchor, constant: -5).isActive = true
        chicken.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.33).isActive = true
        chicken.heightAnchor.constraint(equalToConstant: self.view.frame.width*0.33/aspect).isActive = true
        chicken.image = chickImg
        
        let potatoImg = UIImage(named: "potato")
        aspect = potatoImg!.size.width/potatoImg!.size.height
        let potato = UIImageView()
        ingsScrollView.addSubview(potato)
        potato.translatesAutoresizingMaskIntoConstraints = false
        potato.trailingAnchor.constraint(equalTo: plate.centerXAnchor, constant: -5).isActive = true
        potato.topAnchor.constraint(equalTo: plate.centerYAnchor, constant: 5).isActive = true
        potato.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.33).isActive = true
        potato.heightAnchor.constraint(equalToConstant: self.view.frame.width*0.33/aspect).isActive = true
        potato.image = potatoImg
        
        let almondsImg = UIImage(named: "almonds")
        aspect = almondsImg!.size.width/almondsImg!.size.height
        let almonds = UIImageView()
        ingsScrollView.addSubview(almonds)
        almonds.translatesAutoresizingMaskIntoConstraints = false
        almonds.leadingAnchor.constraint(equalTo: plate.centerXAnchor, constant: 5).isActive = true
        almonds.topAnchor.constraint(equalTo: plate.centerYAnchor, constant: 5).isActive = true
        almonds.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.33).isActive = true
        almonds.heightAnchor.constraint(equalToConstant: self.view.frame.width*0.33/aspect).isActive = true
        almonds.image = almondsImg
        
        ingsScrollView.bottomAnchor.constraint(equalTo: ingViews[ingViews.count-1].bottomAnchor, constant: 30).isActive = true
        
    }
}
