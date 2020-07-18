//
//  Restaurant.swift
//  ForkIt
//
//  Created by Mihikaa Goenka on 7/28/19.
//  Copyright © 2019 Mihikaa Goenka. All rights reserved.
//

import Foundation
import UIKit

protocol Filter {
    var filterTitle: String { get }
}

enum CuisineType: Filter {
    case american
    case continental
    case chinese
    case indian
    case japanese
    case italian
    case dessert
    
    var filterTitle: String { //return the enum title with first letter uppercased
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [CuisineType] {
        return [.american,.continental, .chinese,.indian,.japanese, .italian, .dessert]
    }
}

enum MealTime: Filter {
    case breakfast
    case lunch
    case dinner
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [MealTime] {
        return [.breakfast,.lunch,.dinner]
    }
}

enum Cost: Filter {
    case cheap
    case moderate
    case expensive
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [Cost] {
        return [.cheap,.moderate,.expensive]
    }
}


class Restaurant{
    
    var foodImage: UIImage?
    let restaurantName: String
    let cuisineName: [CuisineType]
    let mealTimes: [MealTime]
    let cost: Cost //only can have one type of cost

    init(imageName: String, restaurantName: String, cuisineName: [CuisineType], mealTimes: [MealTime], cost: Cost){
        self.foodImage = UIImage(named: imageName)
        self.restaurantName = restaurantName
        self.cuisineName = cuisineName
        self.mealTimes = mealTimes
        self.cost = cost
    }
}

