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
    func request(_ request: RestSearchRequest,
                 completion: @escaping (Result<RestSearchRequest.Response, APIError<RestSearchRequest>>) -> Void)
}

final class RestSearchDataStoreImpl: RestSearchDataStore {

    var apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func request(_ request: RestSearchRequest,
                 completion: @escaping (Result<RestSearchRequest.Response, APIError<RestSearchRequest>>) -> Void) {
        self.apiClient.request(request: request, completion: completion)
    }
}
