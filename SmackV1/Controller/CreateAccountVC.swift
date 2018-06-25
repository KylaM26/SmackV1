//
//  CreateAccountVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ChooseAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func GenerateBGPressed(_ sender: Any) {
        
    }
    
    @IBAction func CreateAccountPressed(_ sender: Any) {
        // Register User!
        guard let email = emailTxtField.text, emailTxtField.text != "" else { return; }
        guard  let password = passwordTxtField.text, passwordTxtField.text != "" else { return; }
        
        AuthService.instance.RegisterUser(email: email, password: password) { (success) in
            if success {
                print("User successfully registered");
            } else {
                print("Did not register user.");
            }
        }
    
    }

    @IBAction func ExitPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_CHANNEL, sender: nil);
    }

}
