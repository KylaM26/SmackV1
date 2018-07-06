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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var avatarName = "profileDefault";
    var avatarColor = "[0.5, 0.5, 0.5, 1]";
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName);
            avatarName = UserDataService.instance.avatarName;
            
            if(avatarName.contains("light") && bgColor == nil) {
                userImage.backgroundColor = UIColor.lightGray;
            }
        }
    }
    
    @IBAction func ChooseAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: AVATAR_PICKER_SEGUE, sender: nil);
    }
    
    @IBAction func GenerateBGPressed(_ sender: Any) {
        let red = CGFloat(arc4random_uniform(255)) / 255;
        let green = CGFloat(arc4random_uniform(255)) / 255;
        let blue  = CGFloat(arc4random_uniform(255)) / 255;
        
        bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0);
        
        UIView.animate(withDuration: 0.5) {
            self.userImage.backgroundColor = self.bgColor;
        }
    }
    
    @IBAction func CreateAccountPressed(_ sender: Any) {
        // Register User!
        guard let email = emailTxtField.text, emailTxtField.text != "" else { return; }
        guard let password = passwordTxtField.text, passwordTxtField.text != "" else { return; }
        guard let name = usernameTxtField.text, usernameTxtField.text != "" else { return; }
        
        AuthService.instance.RegisterUser(email: email, password: password) { (success) in
            self.activityIndicator.isHidden = false;
            self.activityIndicator.startAnimating();
            if success {
                AuthService.instance.LoginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.CreateUserAccount(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.activityIndicator.isHidden = true;
                                self.activityIndicator.stopAnimating();
                                print(UserDataService.instance.name, UserDataService.instance.id);
                                self.performSegue(withIdentifier: UNWIND_CHANNEL, sender: nil);
                                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil);
                            }
                        })
                    }
                })
            }
        }
    }
    
    func SetupView() {
        print("SetupView was called.");
        usernameTxtField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]);
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]);
        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]);
        activityIndicator.isHidden = true;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.HandleTap));
        view.addGestureRecognizer(tap);
    }

    @objc func HandleTap() { // Will end keyboard editing
        view.endEditing(true);
    }
    
    @IBAction func ExitPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_CHANNEL, sender: nil);
    }

}
