//
//  AddChannelVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 7/31/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var descriptionTxtField: UITextField!
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        SetUpView();
    }
    
    func SetUpView(){
        let closeTouch = UITapGestureRecognizer(target: CloseTap, action: #selector(AddChannelVC.CloseTap(_:)))
        bgView.addGestureRecognizer(closeTouch);
        
        titleTxtField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]);
        descriptionTxtField.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]);
    }
    
    @IBAction func CloseBtnPressed(_sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func CreateChannelPressed(_sender: Any) {
        
    }
    
    @objc func CloseTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil);
    }
}
