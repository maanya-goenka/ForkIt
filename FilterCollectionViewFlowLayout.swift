//
//  FilterCollectionViewFlowLayout.swift
//  ForkIt
//
//  Created by Mihikaa Goenka on 8/2/19.
//  Copyright © 2019 Mihikaa Goenka. All rights reserved.
//

import UIKit

class FilterCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    let edgeInset: CGFloat = 6
    let itemHeight: CGFloat = 34
    let itemWidth: CGFloat = 100
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        minimumLineSpacing = edgeInset
        minimumInteritemSpacing = edgeInset
        scrollDirection = .horizontal
        sectionInset = .zero
    }
}

