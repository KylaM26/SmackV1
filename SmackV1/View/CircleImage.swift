//
//  CircleImage.swift
//  SmackV1
//
//  Created by Kyla Wilson on 7/6/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        SetupImage();
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        SetupImage();
    }
    
    func SetupImage() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.clipsToBounds = false;
    }
    
}
