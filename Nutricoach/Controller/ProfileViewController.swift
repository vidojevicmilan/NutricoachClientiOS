//
//  ProfileViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 10/25/18.
//  Copyright © 2018 Milan Vidojevic. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("PROFILE VIEW CONTROLLER")
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
