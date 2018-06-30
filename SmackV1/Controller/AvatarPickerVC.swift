//
//  AvatarPickerVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/30/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var avatarCollection: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var avatarType = AvatarType.imageDark;

    override func viewDidLoad() {
        super.viewDidLoad()
        avatarCollection.delegate = self;
        avatarCollection.dataSource = self;
    }
    
    @IBAction func ToggleSegment(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            avatarType = AvatarType.imageDark;
        } else {
            avatarType = AvatarType.imageLight;
        }
        avatarCollection.reloadData();
    }

    @IBAction func BackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns:CGFloat = 3;
        
        if UIScreen.main.bounds.width > 320 { // if the width is wider than iPhone SE width
            numberOfColumns = 4;
        }
        
        let spaceBetweenCells: CGFloat = 10;
        let padding: CGFloat = 20;
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns;
        print(cellDimension);
        
        return CGSize(width: cellDimension, height: cellDimension);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = avatarCollection.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCell {
            cell.UpdateCell(index: indexPath.row, type: avatarType);
            return cell;
        }
        return UICollectionViewCell();
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == AvatarType.imageDark {
            UserDataService.instance.SetAvatarName(avatarName:"dark\(indexPath.item)");
        } else {
            UserDataService.instance.SetAvatarName(avatarName:"light\(indexPath.item)");
        }
        self.dismiss(animated: true, completion: nil);
    }
}
