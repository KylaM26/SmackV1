//
//  CreateAccountVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func ExitPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_CHANNEL, sender: nil);
    }
}
