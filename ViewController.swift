//
//  ViewController.swift
//  ForkIt
//
//  Created by Mihikaa Goenka on 7/28/19.
//  Copyright © 2019 Mihikaa Goenka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    var collectionViewRestaurant: UICollectionView!
    var collectionViewFilters: UICollectionView!
    var refreshControl : UIRefreshControl!
    
    var filters: [Filter] = []
    var activeCostFilter: Set<Cost> = []
    var activeMealTimeFilter: Set<MealTime> = []
    var activeCuisineTypeFilter: Set<CuisineType> = []
    
    var restaurants : [Restaurant] = []
    var activeRestaurants : [Restaurant] = []

    let photoCellReuseIdentifier = "photoCellReuseIdentifier"
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let padding: CGFloat = 8
    let filterCollectionViewHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ForkIt"
        view.backgroundColor = .black
        edgesForExtendedLayout = [] // gets rid of views going under navigation controller
        
        restaurants = RestAPI.getRestaurants()
        activeRestaurants = restaurants
        filters = RestAPI.getFilters()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        collectionViewRestaurant = UICollectionView(frame: .zero, collectionViewLayout: RestaurantCollectionViewFlowLayout())
        collectionViewRestaurant.translatesAutoresizingMaskIntoConstraints = false
        collectionViewRestaurant.backgroundColor = .black
        collectionViewRestaurant.dataSource = self
        collectionViewRestaurant.delegate = self
        collectionViewRestaurant.refreshControl = refreshControl
        collectionViewRestaurant.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: photoCellReuseIdentifier)
        view.addSubview(collectionViewRestaurant)
        
        collectionViewFilters = UICollectionView(frame: .zero, collectionViewLayout: FilterCollectionViewFlowLayout())
        collectionViewFilters.translatesAutoresizingMaskIntoConstraints = false
        collectionViewFilters.backgroundColor = .clear
        collectionViewFilters.dataSource = self
        collectionViewFilters.delegate = self
        collectionViewFilters.allowsMultipleSelection = true
        collectionViewFilters.showsHorizontalScrollIndicator = false
        collectionViewFilters.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        view.addSubview(collectionViewFilters)

        setupConstraints()
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            collectionViewFilters.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewFilters.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewFilters.topAnchor.constraint(equalTo: view.topAnchor),
            collectionViewFilters.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionViewFilters.heightAnchor.constraint(equalToConstant: filterCollectionViewHeight)])
        
        NSLayoutConstraint.activate([
            collectionViewRestaurant.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            collectionViewRestaurant.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewRestaurant.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionViewRestaurant.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    @objc func pulledToRefresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.refreshControl.endRefreshing()
        }
    }
    
    //Collection View Delegates and Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if collectionView == collectionViewFilters{
            return filters.count
        }
        else{
            return activeRestaurants.count
        }
    }
    
    //add filter on selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewFilters {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return }
            let currentFilter = filters[indexPath.item]
            changeFilter(filter: currentFilter, shouldRemove: false)
            collectionViewRestaurant.reloadData()
        }
    }
    
    //remove filter on deselection
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewFilters {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return }
            let currentFilter = filters[indexPath.item]
            changeFilter(filter: currentFilter, shouldRemove: true)
            collectionViewRestaurant.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewFilters {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
            let filter = filters[indexPath.item]
            cell.configure(for: filter)
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as? RestaurantCollectionViewCell else { return UICollectionViewCell() }
            let restaurant = activeRestaurants[indexPath.item]
            cell.configure(for: restaurant)
            return cell
        }
    }
    
    
    func changeFilter(filter: Filter, shouldRemove: Bool = false) {
        if let cuisineType = filter as? CuisineType {
            if shouldRemove {
                activeCuisineTypeFilter.remove(cuisineType)
            } else {
                activeCuisineTypeFilter.insert(cuisineType)
            }
        }
        if let mealTime = filter as? MealTime {
            if shouldRemove {
                activeMealTimeFilter.remove(mealTime)
            } else {
                activeMealTimeFilter.insert(mealTime)
            }
        }
        if let cost = filter as? Cost {
            if shouldRemove {
                activeCostFilter.remove(cost)
            } else {
                activeCostFilter.insert(cost)
            }
        }
        filterRestaurants() //now filter the restaurants according to our activeFilters
    }
    
    func filterRestaurants(){
        if activeCuisineTypeFilter.count == 0 && activeMealTimeFilter.count == 0 && activeCostFilter.count == 0{
            activeRestaurants = restaurants
            return
        }
        activeRestaurants = restaurants.filter({ r in
            var mealTimeFilteredOut = activeMealTimeFilter.count > 0
            if activeMealTimeFilter.count > 0 {
                for mealTime in r.mealTimes {
                    if activeMealTimeFilter.contains(mealTime) {
                        mealTimeFilteredOut = false
                    }
                }
            }
            
            var cuisineTypeFilteredOut = activeCuisineTypeFilter.count > 0
            if activeCuisineTypeFilter.count > 0 {
                for cuisineType in r.cuisineName {
                    if activeCuisineTypeFilter.contains(cuisineType) {
                        cuisineTypeFilteredOut = false
                    }
                }
            }
            
            var costFilteredOut = activeCostFilter.count > 0
            if activeCostFilter.count > 0 {
                if activeCostFilter.contains(r.cost){
                    costFilteredOut = false
                    }
                }
            return !(cuisineTypeFilteredOut||mealTimeFilteredOut||costFilteredOut)
        })
    }
}
