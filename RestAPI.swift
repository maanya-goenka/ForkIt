//
//  RestAPI.swift
//  ForkIt
//
//  Created by Mihikaa Goenka on 8/2/19.
//  Copyright © 2019 Mihikaa Goenka. All rights reserved.
//

import Foundation

class RestAPI {
    
    static func getRestaurants() -> [Restaurant] {
        let dominoes = Restaurant(imageName: "dominoes.jpeg", restaurantName: "Dominoes", cuisineName: [.italian], mealTimes: [.lunch,.dinner], cost: .cheap)
        let mezunna = Restaurant(imageName: "mezunna.jpeg", restaurantName: "Mezunna", cuisineName: [.american, .italian], mealTimes: [.lunch,.dinner], cost: .moderate)
        let belgianwaffles = Restaurant(imageName: "belgianwaffles.jpeg", restaurantName: "Belgian Waffles", cuisineName: [.dessert], mealTimes: [.breakfast,.lunch,.dinner], cost: .cheap)
        let brickwood = Restaurant(imageName: "brickwood.jpeg", restaurantName: "Brickwood", cuisineName: [.american, .italian], mealTimes: [.lunch,.dinner], cost: .moderate)
        let haagendazs = Restaurant(imageName: "haagendazs.jpeg", restaurantName: "Haagendazs", cuisineName: [.dessert], mealTimes: [.breakfast,.lunch,.dinner], cost: .cheap)
        let azad_hind = Restaurant(imageName: "azad hind.jpeg", restaurantName: "Azad Hind", cuisineName: [.indian], mealTimes: [.breakfast,.lunch,.dinner], cost: .cheap)
        let kaafila = Restaurant(imageName: "kaafila.jpeg", restaurantName: "Kaafila", cuisineName: [.indian], mealTimes: [.lunch,.dinner], cost: .moderate)
        let chilis = Restaurant(imageName: "chilis.jpeg", restaurantName: "Chilis", cuisineName: [.continental], mealTimes: [.lunch, .dinner], cost: .expensive)
        let big_fat_belly = Restaurant(imageName: "bigfatbelly.jpeg", restaurantName: "Big Fat Belly", cuisineName: [.american], mealTimes: [.lunch, .dinner], cost: .moderate)
        let yauatcha = Restaurant(imageName: "yauatcha.jpeg", restaurantName: "Yauatcha", cuisineName: [.japanese], mealTimes: [.lunch, .dinner], cost: .expensive)
        let flurys = Restaurant(imageName: "flurys.jpeg", restaurantName: "Flurys", cuisineName: [.dessert], mealTimes: [.breakfast, .lunch, .dinner], cost: .cheap)
        let dampukht = Restaurant(imageName: "dampukht.jpeg", restaurantName: "Dam Pukht", cuisineName: [.indian] , mealTimes: [.lunch, .dinner], cost: .expensive)
        let afraa = Restaurant(imageName: "afraa.jpeg", restaurantName: "Afraan", cuisineName: [.continental], mealTimes: [.breakfast, .lunch, .dinner], cost: .moderate)
        let mainland = Restaurant(imageName: "mainland.jpeg", restaurantName: "Mainland China", cuisineName: [.chinese], mealTimes: [.lunch, .dinner], cost: .expensive)
        let pizzahut = Restaurant(imageName: "pizzahut.jpeg", restaurantName: "Pizza Hut", cuisineName: [.italian], mealTimes: [.lunch, .dinner], cost: .cheap)
        let restaurants = [dominoes, belgianwaffles, kaafila, big_fat_belly, yauatcha, chilis, mezunna, haagendazs, azad_hind, brickwood, flurys, dampukht, mainland, pizzahut, afraa]
        return restaurants
    }
    
    static func getFilters() -> [Filter] {
        var filters: [Filter] = []
        filters.append(contentsOf: MealTime.allValues().map({ f in f as Filter }))
        filters.append(contentsOf: Cost.allValues().map({ f in f as Filter }))
        filters.append(contentsOf: CuisineType.allValues().map({ f in f as Filter }))
        return filters
    }
}
