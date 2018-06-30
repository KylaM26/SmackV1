//
//  AvatarCell.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/30/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

enum AvatarType {
    case imageDark
    case imageLight
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        ConfigureCell();
    }
    
    func UpdateCell(index: Int, type: AvatarType) {
        if type == AvatarType.imageDark {
            cellImage.image = UIImage(named: "dark\(index)");
            self.layer.backgroundColor = UIColor.lightGray.cgColor;
        } else {
            cellImage.image = UIImage(named: "light\(index)");
            self.layer.backgroundColor = UIColor.gray.cgColor;
        }
        
    }
    
    func ConfigureCell() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor;
        self.layer.cornerRadius = 5.0;
        self.clipsToBounds = true;
    }
    
}
