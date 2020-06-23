//
//  RestaurantListProvider.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class RestaurantListProvider: NSObject {
    private var restaurants: [Restaurant]

    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }

    func append(restaurants: [Restaurant]) {
        self.restaurants.append(contentsOf: restaurants)
    }
}

extension RestaurantListProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RestaurantTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setRestaurant(self.restaurants[indexPath.row])
        return cell
    }
}
