//
//  MealViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 2/9/19.
//  Copyright © 2019 Milan Vidojevic. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import SVProgressHUD

class
MealViewController: UIViewController {

    var meal : Meal?
    var ingViews = [UIView]()
    @IBOutlet weak var containerView: UIView!
    var ingsScrollView : UIScrollView!
    var titleLabel : UILabel!
    var flame : UIImageView!
    var kcal : UILabel!
    var macrosView : UIView!
    var protein : UILabel!
    var carbs : UILabel!
    var fats : UILabel!
    var plate : UIImageView!
    var imagesForPlate = [UIImage]()
    var kcalSum: Int = 0
    var proSum: Float = 0.0
    var carbSum: Float = 0.0
    var fatSum: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIngreedientsScrollView()
    }
    
    func initIngreedientsScrollView(){
        ingsScrollView = UIScrollView()
        containerView.addSubview(ingsScrollView)
        
        ingsScrollView.translatesAutoresizingMaskIntoConstraints = false
        ingsScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        ingsScrollView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        ingsScrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        ingsScrollView.backgroundColor = UIColor.clear
        
        titleLabel = UILabel()
        ingsScrollView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: ingsScrollView.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: ingsScrollView.centerXAnchor).isActive = true
        titleLabel.text = meal?.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        flame = UIImageView()
        ingsScrollView.addSubview(flame)
        flame.translatesAutoresizingMaskIntoConstraints = false
        flame.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        flame.centerXAnchor.constraint(equalTo: ingsScrollView.centerXAnchor).isActive = true
        flame.widthAnchor.constraint(equalToConstant: 50).isActive = true
        flame.heightAnchor.constraint(equalToConstant: 50).isActive = true
        flame.image = UIImage(named: "flame.png")
        
        kcal = UILabel()
        ingsScrollView.addSubview(kcal)
        kcal.translatesAutoresizingMaskIntoConstraints = false
        kcal.topAnchor.constraint(equalTo: flame.bottomAnchor, constant: 6).isActive = true
        kcal.centerXAnchor.constraint(equalTo: ingsScrollView.centerXAnchor).isActive = true
        kcal.text = "?? kcal"
        kcal.font = UIFont.systemFont(ofSize: 20)
        
        macrosView = UIView()
        ingsScrollView.addSubview(macrosView)
        macrosView.translatesAutoresizingMaskIntoConstraints = false
        macrosView.widthAnchor.constraint(equalTo: ingsScrollView.widthAnchor).isActive = true
        macrosView.topAnchor.constraint(equalTo: kcal.bottomAnchor, constant: 6).isActive = true
        macrosView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        protein = UILabel()
        macrosView.addSubview(protein)
        protein.translatesAutoresizingMaskIntoConstraints = false
        protein.leadingAnchor.constraint(equalTo: macrosView.leadingAnchor).isActive = true
        protein.centerYAnchor.constraint(equalTo: macrosView.centerYAnchor).isActive = true
        protein.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3.0).isActive = true
        protein.textAlignment = .center
        protein.textColor = UIColor(red: 0.8627, green: 0.2784, blue: 0.5059, alpha: 1.0)
        protein.text = "Protein\n?"
        protein.numberOfLines = 2
        
        carbs = UILabel()
        macrosView.addSubview(carbs)
        carbs.translatesAutoresizingMaskIntoConstraints = false
        carbs.leadingAnchor.constraint(equalTo: protein.trailingAnchor).isActive = true
        carbs.centerYAnchor.constraint(equalTo: macrosView.centerYAnchor).isActive = true
        carbs.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3.0).isActive = true
        carbs.textAlignment = .center
        carbs.textColor = UIColor(red: 0.9725, green: 0.6745, blue: 0.2627, alpha: 1.0)
        carbs.text = "Carbs\n?"
        carbs.numberOfLines = 2
        
        fats = UILabel()
        macrosView.addSubview(fats)
        fats.translatesAutoresizingMaskIntoConstraints = false
        fats.leadingAnchor.constraint(equalTo: carbs.trailingAnchor).isActive = true
        fats.centerYAnchor.constraint(equalTo: macrosView.centerYAnchor).isActive = true
        fats.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3.0).isActive = true
        fats.textAlignment = .center
        fats.textColor = UIColor(red: 0.2627, green: 0.6157, blue: 0.9137, alpha: 1.0)
        fats.text = "Fats\n?"
        fats.numberOfLines = 2
        
        plate = UIImageView()
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
            amountLab.text = "\((meal?.ingreedients[i].amount)!)\((meal?.ingreedients[i].unit)!)"
            
            //Fetch ingredient data from Firebase
            
            let ingId = meal!.ingreedients[i].id
            let amount = Float(meal!.ingreedients[i].amount) / 100
            
            Database.database().reference().child("ingredients").child(ingId).observeSingleEvent(of: .value) { (snap) in
                let kcal = snap.childSnapshot(forPath: "kcal").value as! Float
                let pro = snap.childSnapshot(forPath: "protein").value as! Float
                let carb = snap.childSnapshot(forPath: "carbs").value as! Float
                let fat = snap.childSnapshot(forPath: "fat").value as! Float
                
                let proLab = UILabel()
                proLab.translatesAutoresizingMaskIntoConstraints = false
                ingView.addSubview(proLab)
                proLab.bottomAnchor.constraint(equalTo: ingView.bottomAnchor, constant: -6).isActive = true
                proLab.leadingAnchor.constraint(equalTo: ingView.leadingAnchor, constant: 3).isActive = true
                proLab.widthAnchor.constraint(equalToConstant: (self.view.frame.width-12)/4).isActive = true
                proLab.text = "Pro: " + String(format: "%.01f",pro*amount) + "g"
                proLab.font = UIFont.systemFont(ofSize: 14)
                proLab.textAlignment = .center
                self.proSum += pro*amount
                self.protein.text = "Protein:\n" + String(format: "%.01f",self.proSum) + "g"
                
                let carbLab = UILabel()
                carbLab.translatesAutoresizingMaskIntoConstraints = false
                ingView.addSubview(carbLab)
                carbLab.bottomAnchor.constraint(equalTo: ingView.bottomAnchor, constant: -6).isActive = true
                carbLab.leadingAnchor.constraint(equalTo: proLab.trailingAnchor).isActive = true
                carbLab.widthAnchor.constraint(equalToConstant: (self.view.frame.width-12)/4).isActive = true
                carbLab.text = "Carb: " + String(format: "%.01f",carb*amount) + "g"
                carbLab.font = UIFont.systemFont(ofSize: 14)
                carbLab.textAlignment = .center
                self.carbSum += carb*amount
                self.carbs.text = "Carbs:\n" + String(format: "%.01f",self.carbSum) + "g"
                
                let fatLab = UILabel()
                fatLab.translatesAutoresizingMaskIntoConstraints = false
                ingView.addSubview(fatLab)
                fatLab.bottomAnchor.constraint(equalTo: ingView.bottomAnchor, constant: -6).isActive = true
                fatLab.leadingAnchor.constraint(equalTo: carbLab.trailingAnchor).isActive = true
                fatLab.widthAnchor.constraint(equalToConstant: (self.view.frame.width-12)/4).isActive = true
                fatLab.text = "Fat: " + String(format: "%.01f",fat*amount) + "g"
                fatLab.font = UIFont.systemFont(ofSize: 14)
                fatLab.textAlignment = .center
                self.fatSum += fat*amount
                self.fats.text = "Fats:\n" + String(format: "%.01f",self.fatSum) + "g"
                
                let kcalLab = UILabel()
                kcalLab.translatesAutoresizingMaskIntoConstraints = false
                ingView.addSubview(kcalLab)
                kcalLab.bottomAnchor.constraint(equalTo: ingView.bottomAnchor, constant: -6).isActive = true
                kcalLab.leadingAnchor.constraint(equalTo: fatLab.trailingAnchor).isActive = true
                kcalLab.widthAnchor.constraint(equalToConstant: (self.view.frame.width-12)/4).isActive = true
                kcalLab.text = "kcal: \(Int(kcal * amount))"
                kcalLab.font = UIFont.systemFont(ofSize: 14)
                kcalLab.textAlignment = .center
                self.kcalSum += Int(kcal*amount)
                self.kcal.text = "Kcal: \(self.kcalSum)"
            }
            
            if imagesForPlate.count < 4 {
                Storage.storage().reference().child("ingredients").child("\(ingId).png").getData(maxSize: 1024*1024*3) { (data, err) in
                    if err != nil {
                        SVProgressHUD.showError(withStatus: err.debugDescription)
                    } else {
                        let ingImg = UIImage(data: data!)
                        self.imagesForPlate.append(ingImg!)
                        let i = self.imagesForPlate.count - 1
                        let width = self.plate.frame.width
                        
                        let imgView = UIImageView()
                        self.plate.addSubview(imgView)
                        imgView.translatesAutoresizingMaskIntoConstraints = false
                        
                        switch i {
                        case 0:
                            
                            imgView.trailingAnchor.constraint(equalTo: self.plate.centerXAnchor).isActive = true
                            imgView.bottomAnchor.constraint(equalTo: self.plate.centerYAnchor).isActive = true
                            imgView.widthAnchor.constraint(equalToConstant: width/2.5).isActive = true
                            imgView.heightAnchor.constraint(equalToConstant: width/2.5).isActive = true
                            imgView.image = ingImg
                            imgView.contentMode = .scaleAspectFit
                            
                        case 1:
                            imgView.leadingAnchor.constraint(equalTo: self.plate.centerXAnchor).isActive = true
                            imgView.topAnchor.constraint(equalTo: self.plate.centerYAnchor).isActive = true
                            imgView.widthAnchor.constraint(equalToConstant: width/2.5).isActive = true
                            imgView.heightAnchor.constraint(equalToConstant: width/2.5).isActive = true
                            imgView.image = ingImg
                            imgView.contentMode = .scaleAspectFit
                            
                        case 2:
                            imgView.trailingAnchor.constraint(equalTo: self.plate.centerXAnchor).isActive = true
                            imgView.topAnchor.constraint(equalTo: self.plate.centerYAnchor).isActive = true
                            imgView.widthAnchor.constraint(equalToConstant: width/2.5).isActive = true
                            imgView.heightAnchor.constraint(equalToConstant: width/2.5).isActive = true
                            imgView.image = ingImg
                            imgView.contentMode = .scaleAspectFit
                            
                        case 3:
                            imgView.bottomAnchor.constraint(equalTo: self.plate.centerYAnchor).isActive = true
                            imgView.leadingAnchor.constraint(equalTo: self.plate.centerXAnchor).isActive = true
                            imgView.widthAnchor.constraint(equalToConstant: width/2.5).isActive = true
                            imgView.heightAnchor.constraint(equalToConstant: width/2.5).isActive = true
                            imgView.image = ingImg
                            imgView.contentMode = .scaleAspectFit
                            
                        default:
                            break
                        }
                    }
                }
            }
        }
        ingsScrollView.bottomAnchor.constraint(equalTo: ingViews[ingViews.count-1].bottomAnchor, constant: 30).isActive = true
    }
}
