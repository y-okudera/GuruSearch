//
//  GAreaLargeSearchDataStore.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

enum GAreaLargeSearchDataStoreProvider {
    static func provide(apiClient: APIClient) -> GAreaLargeSearchDataStore {
        return GAreaLargeSearchDataStoreImpl(apiClient: apiClient)
    }
}

protocol GAreaLargeSearchDataStore: AnyObject {
    func request(_ request: GAreaLargeSearchRequest,
                 completion: @escaping (Result<GAreaLargeSearchRequest.Response, APIError<GAreaLargeSearchRequest>>) -> Void)
}

final class GAreaLargeSearchDataStoreImpl: GAreaLargeSearchDataStore {

    var apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func request(_ request: GAreaLargeSearchRequest,
                 completion: @escaping (Result<GAreaLargeSearchRequest.Response, APIError<GAreaLargeSearchRequest>>) -> Void) {
        self.apiClient.request(request: request, completion: completion)
    }
}
