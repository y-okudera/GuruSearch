//
//  RestaurantListInteractor.swift
//  GuruSearch
//
//  Created by yuoku on 22/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// Presenter -> Interactor
///
/// PresenterからInteractorへの処理依頼を定義
protocol RestaurantListUsecaseInput {
    var output: RestaurantListUsecaseOutput? { get }
    var restSearchDataStore: RestSearchDataStore { get }
    func fetchRestaurantList()
    func notifiedDetailButtonTapped(notification: Notification)
}

final class RestaurantListInteractor: RestaurantListUsecaseInput {
    weak var output: RestaurantListUsecaseOutput?
    let restSearchDataStore: RestSearchDataStore
    var request: RestSearchRequest

    init(restSearchDataStore: RestSearchDataStore, request: RestSearchRequest) {
        self.restSearchDataStore = restSearchDataStore
        self.request = request
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notifiedDetailButtonTapped(notification:)),
            name: .tappedDetailButton, object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func notifiedDetailButtonTapped(notification: Notification) {
        guard let restaurantUrl = notification.object as? String else {
            print("RestaurantUrl is nil.")
            return
        }
        if restaurantUrl.isEmpty {
            print("RestaurantUrl is empty.")
            return
        }

        let url = restaurantUrl.toURL()
        // presenterに通知
        output?.tappedDetailButton(url: url)
    }

    func fetchRestaurantList() {
        self.request.incrementPage()
        restSearchDataStore.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.output?.restaurantsFetchSucceeded(restaurants: response)
                
            case .failure(let apiError):
                let errorMessage = self?.apiErrorToMessage(apiError: apiError)
                self?.output?.restaurantsFetchFailed(errorMessage: errorMessage)
            }
        }
    }
    
    private func apiErrorToMessage(apiError: APIError<RestSearchRequest>) -> String? {
        switch apiError {
        case .errorResponse(errObject: let errorResponse):
            let errorMessages = errorResponse.error.compactMap { $0.message }
            let errorMessage = errorMessages.joined(separator: "\n")
            return errorMessage
            
        default:
            return apiError.errorDescription
        }
    }
}
