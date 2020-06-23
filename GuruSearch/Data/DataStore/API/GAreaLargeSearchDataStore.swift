//
//  GAreaLargeSearchDataStore.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

enum GAreaLargeSearchDataStoreProvider {
    static func provide() -> GAreaLargeSearchDataStore {
        return GAreaLargeSearchDataStoreImpl()
    }
}

protocol GAreaLargeSearchDataStore: AnyObject {
    func request(_ request: GAreaLargeSearchRequest,
                 completion: @escaping (Result<GAreaLargeSearchRequest.Response, APIError<GAreaLargeSearchRequest>>) -> Void)
}

final class GAreaLargeSearchDataStoreImpl: GAreaLargeSearchDataStore {
    func request(_ request: GAreaLargeSearchRequest,
                 completion: @escaping (Result<GAreaLargeSearchRequest.Response, APIError<GAreaLargeSearchRequest>>) -> Void) {
        APIClient.request(request: request, completion: completion)
    }
}
