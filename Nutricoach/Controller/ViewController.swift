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

class ViewController: UIViewController, UITextFieldDelegate{
    
    
    
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var userDefEmail :String?
    var userDefPass :String?
    var justSignedOut :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SVProgressHUD.show(withStatus: "Welcome")
        emailTextView.delegate = self
        passwordTextView.delegate = self
        assignbackground()
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        //If not just logged out from profile VC
        if(!justSignedOut){
            //Try signIn using UserDefaults E-mail & Password, if successfull, invoke Home Screen.
            userDefEmail = UserDefaults.standard.string(forKey: "firebaseEmail")
            userDefPass = UserDefaults.standard.string(forKey: "firebasePass")
            
            if(userDefEmail != nil && userDefPass != nil){
                Auth.auth().signIn(withEmail: userDefEmail!, password: userDefPass!) { (result, error) in
                    if(result != nil){
                        self.signinSuccessfull()
                    }
                }
            }else{
                SVProgressHUD.dismiss(withDelay: 1)
            }
        }else{
            SVProgressHUD.showSuccess(withStatus: "Successfully signed out")
            SVProgressHUD.dismiss(withDelay: 1)
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 1.5)
        let email = emailTextView.text
        let password = passwordTextView.text
        
        if email == nil || password == nil{
            return
        }else{
            //Attempt Firebase login/register
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                if error != nil{
                    Auth.auth().createUser(withEmail: email!, password: password!, completion: { (result, error) in
                        if error != nil{
                            SVProgressHUD.showError(withStatus: "Error registering")
                        }
                        else{
                            let values = ["name": email,"email": email]
                            Database.database().reference().child("users").child((result?.user.uid)!).updateChildValues(values as [AnyHashable : Any])
                            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result, error) in
                                if error != nil{
                                    SVProgressHUD.showError(withStatus: "Error signing in")
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
    }
    
    
    func signinSuccessfull(){
        SVProgressHUD.showSuccess(withStatus: "Signed In")
        SVProgressHUD.dismiss(withDelay: 1)
        performSegue(withIdentifier: "goToHome", sender: self)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillChange(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y = -keyboardRect.height
        } else{
            view.frame.origin.y = 0
        }
    }
    
    func assignbackground(){
        let number = Int.random(in: 1 ... 6)
        let background = UIImage(named: "background\(number)")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    
}

class Toast{
    static func show(message : String, controller: UIViewController) {
        
        let toastLabel = UILabel(frame: CGRect(x: 30, y: controller.view.frame.size.height-200, width: controller.view.frame.width-60, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        controller.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

