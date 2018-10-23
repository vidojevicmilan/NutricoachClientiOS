//
//  ViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 10/11/18.
//  Copyright © 2018 Milan Vidojevic. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SVProgressHUD.show()
        //Try signIn using UserDefaults E-mail & Password, if successfull, invoke Home Screen.
        let userDefEmail = UserDefaults.standard.string(forKey: "firebaseEmail")
        let userDefPass = UserDefaults.standard.string(forKey: "firebasePass")
        
        if(userDefEmail != nil && userDefPass != nil){
            Auth.auth().signIn(withEmail: userDefEmail!, password: userDefPass!) { (result, error) in
                if(result != nil){
                    print("Signed In")
                    self.signinSuccessfull()
                }
            }
        }
        SVProgressHUD.dismiss()
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        let email = emailTextView.text
        let password = passwordTextView.text
        
        if email == nil || password == nil{
            return
        }else{
            //Attempt Firebase login/register
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                if error != nil{
                    print(error.debugDescription)
                    Auth.auth().createUser(withEmail: email!, password: password!, completion: { (result, error) in
                        if error != nil{
                            print(error.debugDescription)
                        }
                        else{
                            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result, error) in
                                if error != nil{
                                    print(error.debugDescription)
                                }else{
                                    //write signedIn e-mail & password to UserDefaults
                                    UserDefaults.standard.set(email!, forKey: "firebaseEmail")
                                    UserDefaults.standard.set(password!, forKey: "firebasePass")
                                    self.signinSuccessfull()
                                }})
                        }})
                }else{
                    UserDefaults.standard.set(email!, forKey: "firebaseEmail")
                    UserDefaults.standard.set(password!, forKey: "firebasePass")
                    self.signinSuccessfull()
                }
            }
        }
        SVProgressHUD.dismiss()
    }
    
    func signinSuccessfull(){
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
}

