//
//  ProfileViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 10/25/18.
//  Copyright © 2018 Milan Vidojevic. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var activityTextField: UITextField!
    
    var userId = Auth.auth().currentUser?.uid
    var users = Database.database().reference().child("users")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        users.child(userId!).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot)
            self.nameTextField.text = snapshot.childSnapshot(forPath: "name").value as? String
            self.ageTextField.text = "\(snapshot.childSnapshot(forPath: "userInfo/age").value as? Int ?? 0) years"
            self.heightTextField.text = "\(snapshot.childSnapshot(forPath: "userInfo/height").value as? Int ?? 0) cm"
            self.weightTextField.text = "\(snapshot.childSnapshot(forPath: "userInfo/weight").value as? Float ?? 0) kg"
            self.goalTextField.text = snapshot.childSnapshot(forPath: "userInfo/goal").value as? String
            self.activityTextField.text = snapshot.childSnapshot(forPath: "userInfo/activity").value as? String
        }
    }
    
    @IBAction func signOutButtonClick(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
        }catch{
            Toast.show(message: "Error", controller: self)
            return
        }
        
        UserDefaults.standard.removeObject(forKey: "firebaseEmail")
        UserDefaults.standard.removeObject(forKey: "firebasePass")
        performSegue(withIdentifier: "backToLogin", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToLogin"{
            let loginVC = segue.destination as! ViewController
            loginVC.justSignedOut = true
        }
    }
}
