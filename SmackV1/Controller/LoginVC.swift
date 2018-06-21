//
//  LoginVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func ExitLoginVC(sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func CreateAccountPressed(sender: Any) {
        performSegue(withIdentifier: CREATE_ACCOUNT_SEGUE, sender: nil);
    }
}
