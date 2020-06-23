//
//  RestaurantListViewController.swift
//  GuruSearch
//
//  Created by yuoku on 22/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

/// Presenter -> View
///
/// PresenterからViewへのUI更新を定義
protocol RestaurantListView: AnyObject {
    var presenter: RestaurantListPresentable! { get }
    var restaurantListProvider: RestaurantListProvider! { get }
    func setNavigationTitle(title: String)
    func reloadRestaurantList(restaurants: [Restaurant])
    func showAlert(message: String)
}

final class RestaurantListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
        }
    }
    var presenter: RestaurantListPresentable!
    var restaurantListProvider: RestaurantListProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension RestaurantListViewController {
    private func setup() {
        tableView.registerCell(cellType: RestaurantTableViewCell.self)
        tableView.dataSource = restaurantListProvider

        startAnimating()
        presenter.viewDidLoad()
    }
}

extension RestaurantListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isNearBottomEdge() {
            presenter.fetchMore()
        }
    }
}

extension RestaurantListViewController: RestaurantListView {
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }

    func reloadRestaurantList(restaurants: [Restaurant]) {
        stopAnimating()
        restaurantListProvider.append(restaurants: restaurants)
        tableView.reloadData()
    }

    func showAlert(message: String) {
        stopAnimating()
        UIAlertController.alert(on: self, message: message)
    }
}
