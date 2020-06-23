//
//  RestSearchDataStore.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

enum RestSearchDataStoreProvider {
    static func provide() -> RestSearchDataStore {
        return RestSearchDataStoreImpl()
    }
}

protocol RestSearchDataStore: AnyObject {
    func request(_ request: RestSearchRequest,
                 completion: @escaping (Result<RestSearchRequest.Response, APIError<RestSearchRequest>>) -> Void)
}

final class RestSearchDataStoreImpl: RestSearchDataStore {
    func request(_ request: RestSearchRequest,
                 completion: @escaping (Result<RestSearchRequest.Response, APIError<RestSearchRequest>>) -> Void) {
        APIClient.request(request: request, completion: completion)
    }
}
