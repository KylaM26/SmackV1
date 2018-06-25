//
//  RoundedCorners.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/23/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedCorners: UIButton {
    
    func SetupView() {
        self.layer.cornerRadius = cornerRadius;
    }

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            SetupView();
        }
    }
    
    override func awakeFromNib() {
        self.SetupView();
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder();
        self.SetupView();
    }
}
