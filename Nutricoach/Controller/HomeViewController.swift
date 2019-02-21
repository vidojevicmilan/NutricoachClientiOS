//
//  HomeViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 10/23/18.
//  Copyright © 2018 Milan Vidojevic. All rights reserved.
//

import UIKit
import Firebase
import BLTNBoard
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    var content: UIView!
    var meals = [Meal]()
    var mealsScrollView: UIScrollView!
    var days: UIScrollView!
    let mealsDB = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("mealPlan")
    let user = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
    var imgv : UIImageView!
    var mealViews = [UIView]()
    var tappedViewIndex: Int?
    
    var daysButtons = [UIButton]()
    
    var enteredName: String?
    var enteredAge: Int?
    var enteredHeight: Int?
    var enteredWeight: Float?
    var enteredGoal: String?
    var enteredActivity: String?
    
    lazy var bulletinManager: BLTNItemManager = {
        let root: BLTNItem = makeWelcomeBulletin()
        return BLTNItemManager(rootItem: root)
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBackground()
        chatButtonImageInit()
        user.child("hasCompletedRegistration").observeSingleEvent(of: .value) { (snap) in
            let registrationCompleted = snap.value as? Bool ?? false
            if !registrationCompleted {
                self.initSurvey()
                
            } else {
                self.initData()
            }
        }
    }
    
    private func initSurvey() {
        self.bulletinManager.showBulletin(above: self)
    }
    
    private func initData() {
        user.child("userInfo").observe(.value) { (snap) in
            let children = snap.value as? [String:Any]
            self.enteredAge = children!["age"] as? Int
            self.enteredHeight = children!["height"] as? Int
            self.enteredWeight = children!["weight"] as? Float
            self.enteredGoal = children!["goal"] as? String
            self.enteredActivity = children!["activity"] as? String
            
            self.goalsViewInit()
            self.daysScrollViewInit()
            self.mealsScrollViewInit()
            self.fetchMeals(for: Date())
        }
    }
    
    func makeWelcomeBulletin() -> BLTNPageItem {
        let root: BLTNPageItem = BLTNPageItem(title: "Welcome")
        root.descriptionText = "We will go through the initial registration. When you are ready, tap \"Next\""
        root.image = UIImage(named: "welcome")
        root.actionButtonTitle = "Next"
        root.isDismissable = false
        root.next = makeNameBulletin()
        root.actionHandler = { (item: BLTNActionItem) in
            print("Action button tapped")
            root.manager?.displayNextItem()
        }
        return root
    }
    
    func makeNameBulletin() -> BLTNPageItem {
        let page = NamePageBulletinItem(title: "What is your Name?")
        page.isDismissable = false
        page.image = UIImage(named: "name")
        page.descriptionText = "Please tell us your name, and tap next"
        page.actionButtonTitle = "Next"
        page.next = makeAgeBulletin()
        page.actionHandler = { (item: BLTNActionItem) in
            print("Name button tapped")
            if page.nameField.text != "" {
                self.enteredName = page.nameField.text
                page.manager?.displayNextItem()
            } else {
                SVProgressHUD.showError(withStatus: "Enter Name!")
                SVProgressHUD.dismiss(withDelay: 1)
            }
            
        }
        
        return page
    }
    
    func makeAgeBulletin() -> BLTNPageItem {
        let page = AgePageBulletinItem(title: "What is your Age?")
        page.isDismissable = false
        page.descriptionText = "Please tell us your age, and tap next"
        page.actionButtonTitle = "Next"
        page.image = UIImage(named: "age")
        page.next = makeHeightBulletin()
        page.actionHandler = { (item: BLTNActionItem) in
            if page.ageField.text != "" {
                self.enteredAge = Int(page.ageField.text!)
                if self.enteredAge != nil {
                    if self.enteredAge! > 18 {
                        page.manager?.displayNextItem()
                    } else {
                        SVProgressHUD.showError(withStatus: "You must be over 18")
                        SVProgressHUD.dismiss(withDelay: 1)
                    }
                } else {
                    SVProgressHUD.showError(withStatus: "Invalid nubmer!")
                    SVProgressHUD.dismiss(withDelay: 1)
                }
                
            } else {
                SVProgressHUD.showError(withStatus: "Enter Age!")
                SVProgressHUD.dismiss(withDelay: 1)
            }
        }
        return page
    }
    
    func makeHeightBulletin() -> BLTNPageItem {
        let page = HeightPageBulletinItem(title: "What is your Height?")
        page.isDismissable = false
        page.descriptionText = "Please tell us your height, and tap next"
        page.actionButtonTitle = "Next"
        page.image = UIImage(named: "height")
        page.next = makeWeightBulletin()
        page.actionHandler = { (item: BLTNActionItem) in
            if page.heightField.text != "" {
                self.enteredHeight = Int(page.heightField.text!)
                if self.enteredHeight != nil {
                    if self.enteredHeight! > 140 && self.enteredHeight! < 220 {
                        page.manager?.displayNextItem()
                    } else {
                        SVProgressHUD.showError(withStatus: "Invalid Height!")
                        SVProgressHUD.dismiss(withDelay: 1)
                    }
                } else {
                    SVProgressHUD.showError(withStatus: "Invalid Height!")
                    SVProgressHUD.dismiss(withDelay: 1)

                }
            } else {
                SVProgressHUD.showError(withStatus: "Enter Height!")
                SVProgressHUD.dismiss(withDelay: 1)
            }
        }
        return page
    }
    
    func makeWeightBulletin() -> BLTNPageItem {
        let page = WeightPageBulletinItem(title: "What is your Weight?")
        page.isDismissable = false
        page.descriptionText = "Please tell us your weight, and tap next"
        page.actionButtonTitle = "Next"
        page.image = UIImage(named: "weight")
        page.next = makeGoalBulletin()
        page.actionHandler = { (item: BLTNActionItem) in
            if page.weightField.text != "" {
                self.enteredWeight = Float(page.weightField.text!)
                if self.enteredWeight != nil {
                    if self.enteredWeight! > 40 && self.enteredWeight! < 160 {
                        page.manager?.displayNextItem()
                    } else {
                        SVProgressHUD.showError(withStatus: "Invalid Weight!")
                        SVProgressHUD.dismiss(withDelay: 1)
                    }
                } else {
                    SVProgressHUD.showError(withStatus: "Invalid Weight!")
                    SVProgressHUD.dismiss(withDelay: 1)
                    
                }
            } else {
                SVProgressHUD.showError(withStatus: "Enter Weight!")
                SVProgressHUD.dismiss(withDelay: 1)
            }
        }
        return page
    }
    
    func makeGoalBulletin() -> BLTNPageItem {
        let page = GoalsPageBulletinItem(title: "What are your goals?")
        page.isDismissable = false
        page.descriptionText = "Please select your goals and tap next"
        page.actionButtonTitle = "Next"
        page.image = UIImage(named: "goal")
        page.next = makeActivityBulletin()
        page.actionHandler = { (item: BLTNActionItem) in
            if !page.selectedButonText.isEmpty {
                self.enteredGoal = page.selectedButonText
                page.manager?.displayNextItem()
            }
            else {
                SVProgressHUD.showError(withStatus: "Select one!")
                SVProgressHUD.dismiss(withDelay: 1)
            }
        }
        return page
    }
    
    func makeActivityBulletin() -> BLTNPageItem {
        let page = ActivityPageBulletinItem(title: "How active are you?")
        page.isDismissable = false
        page.descriptionText = "Describe your activity level throughout the week. \"Little\" being office work with up to one workout weekly, \"Moderate\" for 1-3 workouts per week, \"Very active\" for physically demanding work or 4-6 workouts per week."
        page.actionButtonTitle = "Next"
        page.image = UIImage(named: "activity")
        page.next = makeFinishBulletin()
        page.actionHandler = { (item: BLTNActionItem) in
            if !page.selectedButonText.isEmpty {
                self.enteredActivity = page.selectedButonText
                page.manager?.displayNextItem()
            } else {
                SVProgressHUD.showError(withStatus: "Select one!")
                SVProgressHUD.dismiss(withDelay: 1)
            }
        }
        return page
    }
    
    func makeFinishBulletin() -> BLTNPageItem {
        let page = BLTNPageItem(title: "All set!")
        page.isDismissable = false
        page.descriptionText = "We have all info we need. Give our nutritionist team a little time to make plan for your first step to acomplishing your goal!"
        page.actionButtonTitle = "Finish"
        page.image = UIImage(named: "success")
        page.actionHandler = { (item: BLTNActionItem) in
            //send all info to Firebase, dismiss
            page.manager?.displayActivityIndicator()
            
            let dict : [String:Any] = ["age":self.enteredAge!,"height":self.enteredHeight!,"weight":self.enteredWeight!,"goal":self.enteredGoal!,"activity":self.enteredActivity!]
            
            self.user.child("userInfo").setValue(dict)
            self.user.child("name").setValue(self.enteredName!)
            self.user.child("hasCompletedRegistration").setValue(true)
            
            self.initData()
            
            page.manager?.dismissBulletin(animated: true)
        }
        return page
    }
    
    private func chatButtonImageInit(){
        self.imgv = UIImageView(image: UIImage(named:"icons8-bell-filled-50"))
        self.imgv.frame = CGRect(x: self.chatButton.frame.minX + 37, y: self.chatButton.frame.minY - 8, width: 30, height: 30)
        self.view.addSubview(self.imgv)
        self.imgv.isHidden = true
        user.child("hasUnreadMessages").observe(.value) { (snapshot) in
            if snapshot.value as? String == "true"{
                self.imgv.isHidden = false
            }else{
                self.imgv.isHidden = true
            }
        }
    }
    
    @IBAction func chatButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "goToChat", sender: self)
    }
    
    private func setBackground(){
        contentView.backgroundColor = .clear
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = ViewController.background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    private func goalsViewInit() {
        content = UIView()
        contentView.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6).isActive = true
        content.widthAnchor.constraint(equalToConstant: contentView.frame.width - 12).isActive = true
        content.layer.cornerRadius = 10
        content.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 24)
        content.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: content.topAnchor, constant: 10).isActive = true
        title.centerXAnchor.constraint(equalTo: content.centerXAnchor).isActive = true
        title.numberOfLines = 1
        
        
        let macros = UILabel()
        macros.font = UIFont.systemFont(ofSize: 16)
        content.addSubview(macros)
        macros.translatesAutoresizingMaskIntoConstraints = false
        macros.topAnchor.constraint(equalTo: title.topAnchor, constant: 20).isActive = true
        macros.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 10).isActive = true
        macros.numberOfLines = 0
        
        user.child("prescribedMacros").observe(.value) { (snap) in
            let children = snap.value as? [String:Any]
            let kcal = children?["kcal"] as? Int
            let pro = children?["protein"] as? Int
            let carb = children?["carbs"] as? Int
            let fat = children?["fat"] as? Int
            
            title.text = "Daily goal: \(kcal ?? 0) kcal"
            macros.text = "\nProtein: \(pro ?? 0)g" + "\nFats: \(fat ?? 0)g" + "\nCarbohydrates: \(carb ?? 00)g"
            
            self.content.bottomAnchor.constraint(equalTo: macros.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    private func daysScrollViewInit() {
        days = UIScrollView()
        contentView.addSubview(days)
        days.translatesAutoresizingMaskIntoConstraints = false
        days.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 3).isActive = true
        days.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        days.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        days.heightAnchor.constraint(equalToConstant: 25).isActive = true
        days.backgroundColor = UIColor.clear
        days.showsHorizontalScrollIndicator = false
        
        user.child("mealPlan/dates").observe(.value) { (snap) in
            let dict = snap.value as? [String:Any]
            var keys = [String]()
            
            if !(dict?.isEmpty ?? true) {
                for item in dict! {
                    keys.append(item.key)
                }
            }
            
            for i in 0..<keys.count {
                let button = UIButton()
                self.days.addSubview(button)
                self.daysButtons.append(button)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.setTitle(keys[i], for: .normal)
                button.topAnchor.constraint(equalTo: self.days.topAnchor).isActive = true
                button.heightAnchor.constraint(equalTo: self.days.heightAnchor).isActive = true
                button.widthAnchor.constraint(equalTo: button.titleLabel!.widthAnchor, constant: 10).isActive = true
                button.setTitleColor(.black, for: .normal)
                button.layer.cornerRadius = 10
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .thin)
                button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                if i == 0 {
                    button.leadingAnchor.constraint(equalTo: self.days.leadingAnchor, constant: 6).isActive = true
                } else {
                    button.leadingAnchor.constraint(equalTo: self.daysButtons[i-1].trailingAnchor, constant: 6).isActive = true
                }
                
            }
            if self.daysButtons.count != 0 {
                self.days.trailingAnchor.constraint(equalTo: self.daysButtons.last!.trailingAnchor, constant: 6).isActive = true
                self.daysButtonsHandlersInit()
            }
        }
    }
    
    private func daysButtonsHandlersInit() {
        let form = DateFormatter()
        form.dateFormat = "dd-MM-yyyy"
        let d = form.string(from: Date())
        
        for b in daysButtons {
            b.addTarget(self, action: #selector(self.dayButtonTap), for: .touchUpInside)
            if b.titleLabel?.text == d {
                b.backgroundColor = UIColor(red: 0, green: 131/255, blue: 249/255, alpha: 1)
                b.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    @objc func dayButtonTap(sender: UIButton!){
        for b in daysButtons {
            b.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
            b.setTitleColor(.black, for: .normal)
        }
        sender.backgroundColor = UIColor(red: 0, green: 131/255, blue: 249/255, alpha: 1)
        sender.setTitleColor(.white, for: .normal)
        let form = DateFormatter()
        form.dateFormat = "dd-MM-yyyy"
        let d = form.date(from: sender.titleLabel!.text!)
        mealsScrollView.removeFromSuperview()
        mealsScrollViewInit()
        fetchMeals(for: d!)
    }
    
    private func mealsScrollViewInit() {
        let insetBar = UIView()
        contentView.addSubview(insetBar)
        insetBar.translatesAutoresizingMaskIntoConstraints = false
        insetBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        insetBar.heightAnchor.constraint(equalToConstant: 1).isActive = true
        insetBar.widthAnchor.constraint(equalToConstant: self.view.frame.width - 50).isActive = true
        insetBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        insetBar.topAnchor.constraint(equalTo: days.bottomAnchor, constant: 3).isActive = true
        
        mealsScrollView = UIScrollView()
        contentView.addSubview(mealsScrollView)
        
        mealsScrollView.translatesAutoresizingMaskIntoConstraints = false
        mealsScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mealsScrollView.topAnchor.constraint(equalTo: insetBar.bottomAnchor, constant: 3).isActive = true
        mealsScrollView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        mealsScrollView.backgroundColor = UIColor.clear
    }
    
    private func fetchMeals(for date: Date){
        let form = DateFormatter()
        form.dateFormat = "dd-MM-yyyy"
        let d = form.string(from: date)
        mealsDB.child("dates/\(d)/meals").observe(.value) { (DataSnapshot) in
            self.populateScrollViewWithMeals(meals: DataSnapshot)
        }
    }
    
    private func populateScrollViewWithMeals(meals: DataSnapshot){
        var mealList = [Meal]()
        mealViews = [UIView]()
        let children = meals.children
        for meal in children {
            let m = meal as! DataSnapshot
            let title = m.childSnapshot(forPath: "title").value as! String
            
            var ings = [Ingreedient]()
            let ingreedients = m.childSnapshot(forPath: "ingreedients").children
            for i in ingreedients {
                let ing = i as! DataSnapshot
                let ingr = Ingreedient(name: ing.childSnapshot(forPath: "name").value as! String, amount: ing.childSnapshot(forPath: "amount").value as! Int)
                ings.append(ingr)
            }
            mealList.append(Meal(title: title, ingreedients: ings))
        }
        // We have complete meal list, now make UIVeiws and attach them...
        if !mealList.isEmpty {
            for i in 0...mealList.count - 1{
                let mealView = UIView()
                mealView.translatesAutoresizingMaskIntoConstraints = false
                mealsScrollView.addSubview(mealView)
                mealView.leadingAnchor.constraint(equalTo: mealsScrollView.leadingAnchor, constant: 6).isActive = true
                mealView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 12).isActive = true
                mealView.layer.cornerRadius = 10
                mealView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                mealView.tag = i
                mealViews.append(mealView)
            }
            self.meals = mealList
            for i in 0...mealViews.count - 1 {
                if i == 0 {
                    mealViews[i].topAnchor.constraint(equalTo: self.mealsScrollView.topAnchor).isActive = true
                    initialize(meal: mealList[i], in: mealViews[i])
                } else {
                    mealViews[i].topAnchor.constraint(equalTo: mealViews[i-1].bottomAnchor, constant: 6).isActive = true
                    initialize(meal: mealList[i], in: mealViews[i])
                }
            }
            mealsScrollView.bottomAnchor.constraint(equalTo: (mealViews.last?.bottomAnchor)!, constant: 30).isActive = true
        }
    }
    
    private func initialize(meal: Meal, in view: UIView) {
        let titleLab = UILabel()
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        titleLab.text = meal.title
        view.addSubview(titleLab)
        titleLab.font = UIFont.systemFont(ofSize: 20.0)
        titleLab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLab.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        titleLab.numberOfLines = 0
        
        var previousLab = titleLab
        for ing in meal.ingreedients {
            let lab = UILabel()
            lab.translatesAutoresizingMaskIntoConstraints = false
            lab.text = "\(ing.name) : \(ing.amount)"
            view.addSubview(lab)
            lab.font = UIFont.systemFont(ofSize: 14.0)
            lab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            lab.topAnchor.constraint(equalTo: previousLab.bottomAnchor, constant: 10).isActive = true
            lab.numberOfLines = 0
            previousLab = lab
        }
        
        view.bottomAnchor.constraint(equalTo: previousLab.bottomAnchor, constant: 10).isActive = true
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (goToMealVC (_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func goToMealVC(_ sender: UITapGestureRecognizer){
        print("Meal View \(sender.view!.tag) Tapped")
        tappedViewIndex = sender.view!.tag
        performSegue(withIdentifier: "goToMealVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMealVC" {
            let vc = segue.destination as! MealViewController
            vc.meal = meals[tappedViewIndex!]
        }
    }
    
}
