//
//  RestaurantCollectionViewFlowLayout.swift
//  ForkIt
//
//  Created by Mihikaa Goenka on 8/2/19.
//  Copyright © 2019 Mihikaa Goenka. All rights reserved.
//

import UIKit

class RestaurantCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let cellWidth: CGFloat = 140
    let cellHeight: CGFloat = 140
    let padding: CGFloat = 2
    
    override func prepare() {
        super.prepare()
        let edgeInset = (UIScreen.main.bounds.width - ((3 * cellWidth) + (padding * 2))) / 3
        itemSize = CGSize(width: cellWidth, height: cellHeight)
        minimumLineSpacing = edgeInset
        minimumInteritemSpacing = edgeInset
        //print("\(minimumInteritemSpacing) + \(minimumLineSpacing)")
        sectionInset = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
}
