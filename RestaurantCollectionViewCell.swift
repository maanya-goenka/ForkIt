//
//  RestaurantCollectionViewCell.swift
//  ForkIt
//
//  Created by Mihikaa Goenka on 7/28/19.
//  Copyright © 2019 Mihikaa Goenka. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    var photoImageView : UIImageView!
    var restaurantNameLabel: UILabel!
    var cuisineLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleToFill
        //photoImageView.contentMode = .scaleAspectFit
        contentView.addSubview(photoImageView)
        
        restaurantNameLabel = UILabel()
        restaurantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantNameLabel.font = UIFont.systemFont(ofSize: 14)
        restaurantNameLabel.textColor = .white
        restaurantNameLabel.textAlignment = .center
        contentView.addSubview(restaurantNameLabel)
        
        
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            restaurantNameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            restaurantNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            restaurantNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            restaurantNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    
    }

    
    func configure(for restaurant: Restaurant){
        photoImageView.image = restaurant.foodImage
        restaurantNameLabel.text = restaurant.restaurantName
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
