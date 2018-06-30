//
//  AvatarCell.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/30/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        ConfigureCell();
    }
    
    func ConfigureCell() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor;
        self.layer.cornerRadius = 5.0;
        self.clipsToBounds = true;
    }
    
}
