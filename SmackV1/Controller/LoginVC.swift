//
//  LoginVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginBtn: RoundedCorners!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpView();
    }

    @IBAction func LoginPressed(_ sender: Any) {
        activityIndicator.isHidden = false;
        activityIndicator.startAnimating();
        
        guard let emailOrUsername = userNameTxtField.text, userNameTxtField.text != "" else { return; }
        guard let password = passwordTxtField.text, passwordTxtField.text != "" else { return; }
        
        AuthService.instance.LoginUser(email: emailOrUsername, password: password) { (success) in
            if success {
                AuthService.instance.FindUserByEmail(completeion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil);
                        self.activityIndicator.isHidden = true;
                        self.activityIndicator.stopAnimating();
                        self.dismiss(animated: true, completion: nil);
                    } else {
                        print("Failed to find user");
                    }
                })
            } else {
                print("Failed to log in user");
            }
        }
    }
    
    @IBAction func ExitLoginVC(sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func CreateAccountPressed(sender: Any) {
        performSegue(withIdentifier: CREATE_ACCOUNT_SEGUE, sender: nil);
        loginBtn.isEnabled = false;
    
    }
    
    func SetUpView() {
        userNameTxtField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]);
        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]);
        
        activityIndicator.isHidden = true;
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.HandleTap));
//        view.addGestureRecognizer(tap);
    }
}
