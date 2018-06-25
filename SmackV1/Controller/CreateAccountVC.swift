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
    
    var avatarName = "profileDefault";
    var avatarColor = "[0.5, 0.5, 0.5, 1]";
    
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
        guard let password = passwordTxtField.text, passwordTxtField.text != "" else { return; }
        guard let name = usernameTxtField.text, usernameTxtField.text != "" else { return; }
        
        AuthService.instance.RegisterUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.LoginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.CreateUserAccount(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.id);
                                self.performSegue(withIdentifier: UNWIND_CHANNEL, sender: nil);
                            }
                        })
                    }
                })
            }
        }
    
    }

    @IBAction func ExitPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_CHANNEL, sender: nil);
    }

}
