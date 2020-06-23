//
//  RestaurantListRouter.swift
//  GuruSearch
//
//  Created by yuoku on 22/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

protocol RestaurantListWireframe: AnyObject {
    func showWebBrowserModal(url: URL)
}

final class RestaurantListRouter {
    
    private weak var viewController: UIViewController?
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(gareaLarge: GareaLarge) -> UIViewController {
        let view: RestaurantListViewController = .instantiate()
        view.restaurantListProvider = .init(restaurants: [])
        let router = RestaurantListRouter(viewController: view)

        let restSearchDataStore = RestSearchDataStoreProvider.provide(apiClient: APIClient())
        let restSearchRequest = RestSearchRequest(areacodeL: gareaLarge.areacodeL)
        let interactor = RestaurantListInteractor(restSearchDataStore: restSearchDataStore, request: restSearchRequest)

        let presenter = RestaurantListPresenter(view: view, router: router, interactor: interactor, gareaLarge: gareaLarge)
        
        // Interactorの通知先を設定
        interactor.output = presenter
        // ViewにPresenterを設定
        view.presenter = presenter
        return view
    }
}

extension RestaurantListRouter: RestaurantListWireframe {
    func showWebBrowserModal(url: URL) {
        let webBrowserVC = WebBrowserRouter.assembleModules(initialURL: url)
        viewController?.present(webBrowserVC, animated: true)
    }
}
