//
//  AreaListRouter.swift
//  GuruSearch
//
//  Created by yuoku on 22/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

protocol AreaListWireframe: AnyObject {
    func showRestaurantList(gareaLarge: GareaLarge)
}

final class AreaListRouter {
    
    private weak var viewController: UIViewController?
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModules() -> UIViewController {
        
        let view: AreaListViewController = .instantiate()
        view.areaListProvider = .init(gareaLarge: [])
        let router = AreaListRouter(viewController: view)
        
        let gAreaLargeSearchDataStore = GAreaLargeSearchDataStoreProvider.provide(apiClient: APIClient())
        let gAreaLargeSearchRequest = GAreaLargeSearchRequest()
        let interactor = AreaListInteractor(gAreaLargeSearchDataStore: gAreaLargeSearchDataStore, request: gAreaLargeSearchRequest)
        
        let presenter = AreaListPresenter(view: view, router: router, interactor: interactor)
        
        // Interactorの通知先を設定
        interactor.output = presenter
        // ViewにPresenterを設定
        view.presenter = presenter
        
        return view
    }
}

extension AreaListRouter: AreaListWireframe {
    func showRestaurantList(gareaLarge: GareaLarge) {
        let restaurantListVC = RestaurantListRouter.assembleModules(gareaLarge: gareaLarge)
        viewController?.navigationController?.pushViewController(restaurantListVC, animated: true)
        viewController?.navigationItem.title = gareaLarge.areanameL
    }
}
