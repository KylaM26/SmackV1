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

    override func viewDidLoad() {
        super.viewDidLoad()
        avatarCollection.delegate = self;
        avatarCollection.dataSource = self;
    }
    
    @IBAction func ToggleSegment(_ sender: Any) {
        
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = avatarCollection.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCell {
            
            return cell;
        }
        return UICollectionViewCell();
    }
}
