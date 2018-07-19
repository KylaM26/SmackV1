//
//  ProfileVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 7/17/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpView();
    }

    @IBAction func CloseBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func LogoutBtnPressed(_ sender: Any) {
        UserDataService.instance.LogoutUser();
        NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil);
        dismiss(animated: true, completion: nil);
    }
    
    func SetUpView() {
        userName.text = UserDataService.instance.name;
        email.text = AuthService.instance.userEmail;
        userImage.image = UIImage(named: UserDataService.instance.avatarName);
        userImage.backgroundColor = UserDataService.instance.ReturnUIColor(components: UserDataService.instance.avatarColor);
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)));
        bgView.addGestureRecognizer(closeTouch);
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil);
    }
}
