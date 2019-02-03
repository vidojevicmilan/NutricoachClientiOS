//
//  HomeViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 10/23/18.
//  Copyright © 2018 Milan Vidojevic. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var chatButton: UIButton!
    
    let user = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
    var imgv : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("HOME VIEW CONTROLLER")
        chatButtonImageInit()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
}
