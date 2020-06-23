//
//  AreaListPresenter.swift
//  GuruSearch
//
//  Created by yuoku on 22/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// View -> Presenter
///
/// ViewからPresenterへの処理依頼を定義
protocol AreaListPresentable: AnyObject {
    var view: AreaListView? { get }
    var router: AreaListWireframe { get }
    var interactor: AreaListUsecaseInput { get }
    func viewDidLoad()
    func selectArea(gareaLarge: GareaLarge)
}

/// Interactor -> Presenter
///
/// InteractorからPresenterへの処理結果の通知を定義
protocol AreaListUsecaseOutput: AnyObject {
    func areasFetchSucceeded(areas: Areas)
    func areasFetchFailed(errorMessage: String?)
}

final class AreaListPresenter: AreaListPresentable {
    weak var view: AreaListView?
    let router: AreaListWireframe
    let interactor: AreaListUsecaseInput
    
    init(view: AreaListView?, router: AreaListWireframe, interactor: AreaListUsecaseInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
    	interactor.fetchAreas()
    }

    func selectArea(gareaLarge: GareaLarge) {
        router.showRestaurantList(gareaLarge: gareaLarge)
    }
}

extension AreaListPresenter: AreaListUsecaseOutput {
    func areasFetchSucceeded(areas: Areas) {
        view?.reloadAreaList(areas: areas)
    }

    func areasFetchFailed(errorMessage: String?) {
        guard let errorMessage = errorMessage else {
            print("errorMessage is nil.")
            return
        }
        view?.showAlert(message: errorMessage)
    }
}
