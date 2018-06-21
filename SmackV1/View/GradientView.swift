//
//  GradientView.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit
@IBDesignable // Render inside storyboard

class GradientView: UIView {
    
    @IBInspectable var topColor = #colorLiteral(red: 0, green: 0.2, blue: 0.8, alpha: 1) { // This variable will be seen in inspector.
        didSet { // In storyboard, when the color is set
            self.setNeedsLayout(); // Update the layout, since we changed.
        }
    }
    
    @IBInspectable var bottomColor = #colorLiteral(red: 0.1098039216, green: 0.7098039216, blue: 0.9568627451, alpha: 1) { // This variable will be seen in inspector.
        didSet { // In storyboard, when the color is set
            self.setNeedsLayout(); // Update the layout, since we changed.
        }
    }

    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer();
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor];
        gradientLayer.startPoint = CGPoint(x: 0, y: 0);
        gradientLayer.endPoint = CGPoint(x: 1, y: 1);
        gradientLayer.frame = self.bounds;
        self.layer.insertSublayer(gradientLayer, at: 0); // 0 --> The first layer.
    }
    
}
