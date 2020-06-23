//
//  AreaListInteractor.swift
//  GuruSearch
//
//  Created by yuoku on 22/06/2020.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// Presenter -> Interactor
///
/// PresenterからInteractorへの処理依頼を定義
protocol AreaListUsecaseInput {

    var output: AreaListUsecaseOutput? { get }
    var gAreaLargeSearchDataStore: GAreaLargeSearchDataStore { get }
    func fetchAreas()
}

final class AreaListInteractor: AreaListUsecaseInput {
    weak var output: AreaListUsecaseOutput?
    let gAreaLargeSearchDataStore: GAreaLargeSearchDataStore
    var request: GAreaLargeSearchRequest

    init(gAreaLargeSearchDataStore: GAreaLargeSearchDataStore, request: GAreaLargeSearchRequest) {
        self.gAreaLargeSearchDataStore = gAreaLargeSearchDataStore
        self.request = request
    }

    func fetchAreas() {
        gAreaLargeSearchDataStore.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.output?.areasFetchSucceeded(areas: response)
            case .failure(let apiError):
                let errorMessage = self?.apiErrorToMessage(apiError: apiError)
                self?.output?.areasFetchFailed(errorMessage: errorMessage)
            }
        }
    }

    private func apiErrorToMessage(apiError: APIError<GAreaLargeSearchRequest>) -> String? {
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
