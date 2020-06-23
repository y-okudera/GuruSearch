//
//  RestSearchDataStore.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

enum RestSearchDataStoreProvider {
    static func provide(apiClient: APIClient) -> RestSearchDataStore {
        return RestSearchDataStoreImpl(apiClient: apiClient)
    }
}

protocol RestSearchDataStore: AnyObject {
    func isRequesting() -> Bool
    func request(_ request: RestSearchRequest,
                 completion: @escaping (Result<RestSearchRequest.Response, APIError<RestSearchRequest>>) -> Void)
    func cancel()
}

final class RestSearchDataStoreImpl: RestSearchDataStore {

    private var request: RestSearchRequest?
    var apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func isRequesting() -> Bool {
        if self.request == nil {
            return false
        }
        return true
    }
    
    func request(_ request: RestSearchRequest,
                 completion: @escaping (Result<RestSearchRequest.Response, APIError<RestSearchRequest>>) -> Void) {
        NetworkConnection.isReachable { [weak self] result in
            switch result {
            case .success:
                self?.request = request
                self?.apiClient.request(request: request) { [weak self] result in
                    self?.request = nil
                    completion(result)
                }

            case .failure(let reachabilityError):
                completion(.failure(.reachabilityError(reachabilityError)))
            }
        }
    }

    func cancel() {
        if let url = self.request?.makeURLRequest()?.url {
            print("RestSearch request cancelled.")
            APICanceller.shared.cancel(url: url)
            self.request = nil
        }
    }
}
