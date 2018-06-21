//
//  ChannelVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60; // For slide panel.
    }

    @IBAction func LoginPressed(_ sender: Any) {
        performSegue(withIdentifier: LOGIN_SEGUE, sender: nil);
    }
}
