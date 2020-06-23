//
//  GAreaLargeSearchRequest.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// エリアLマスタ取得API
final class GAreaLargeSearchRequest: APIRequestable {
    typealias Response = Areas
    typealias ErrorResponse = GuruNaviErrorResponse
    let baseURL = "https://api.gnavi.co.jp".toURL()
    let path: String = "/master/GAreaLargeSearchAPI/v3/"
    var parameters: [String: Any] = [:]

    init() {
        createParameters()
    }

    private func createParameters() {
        self.parameters = GuruNaviParamsBuilder.build()
    }
}
