//
//  RestaurantListPresenter.swift
//  GuruSearch
//
//  Created by yuoku on 22/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// View -> Presenter
///
/// ViewからPresenterへの処理依頼を定義
protocol RestaurantListPresentable: AnyObject {
    var view: RestaurantListView? { get }
    var router: RestaurantListWireframe { get }
    var interactor: RestaurantListUsecaseInput { get }
    var gareaLarge: GareaLarge { get }
    func viewDidLoad()
}

/// Interactor -> Presenter
///
/// InteractorからPresenterへの処理結果の通知を定義
protocol RestaurantListUsecaseOutput: AnyObject {
    func restaurantsFetchSucceeded(restaurants: Restaurants)
    func restaurantsFetchFailed(errorMessage: String?)
    func tappedDetailButton(url: URL)
}

final class RestaurantListPresenter: RestaurantListPresentable {
    weak var view: RestaurantListView?
    let router: RestaurantListWireframe
    let interactor: RestaurantListUsecaseInput
    let gareaLarge: GareaLarge
    
    init(view: RestaurantListView?, router: RestaurantListWireframe, interactor: RestaurantListUsecaseInput, gareaLarge: GareaLarge) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.gareaLarge = gareaLarge
    }

    func viewDidLoad() {
        interactor.fetchRestaurantList()
        view?.setNavigationTitle(title: gareaLarge.areanameL)
    }
}

extension RestaurantListPresenter: RestaurantListUsecaseOutput {
    func restaurantsFetchSucceeded(restaurants: Restaurants) {
        view?.reloadRestaurantList(restaurants: restaurants.rest)
    }

    func restaurantsFetchFailed(errorMessage: String?) {
        guard let errorMessage = errorMessage else {
            print("errorMessage is nil.")
            return
        }
        view?.showAlert(message: errorMessage)
    }

    func tappedDetailButton(url: URL) {
        router.showWebBrowserModal(url: url)
    }
}
