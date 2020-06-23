//
//  RestSearchRequest.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// レストラン検索APIリクエスト
final class RestSearchRequest: APIRequestable {
    typealias Response = Restaurants
    typealias ErrorResponse = GuruNaviErrorResponse
    let baseURL = "https://api.gnavi.co.jp".toURL()
    let path: String = "/RestSearchAPI/v3"
    var parameters: [String: Any] = [:]
    
    private let hitPerPage = 25
    private var offsetPage: Int = 0 {
        didSet {
            self.parameters["offset_page"] = "\(offsetPage)"
        }
    }
    
    init(areacodeL: String) {
        createParameters(areacodeL: areacodeL)
    }
    
    private func createParameters(areacodeL: String) {
        var params = GuruNaviParamsBuilder.build()
        params["areacode_l"] = areacodeL
        params["hit_per_page"] = "\(hitPerPage)"
        params["offset_page"] = "\(offsetPage)"
        self.parameters = params
    }
}

extension RestSearchRequest {
    func resetPage() {
        self.offsetPage = 0
    }
    
    func incrementPage() {
        self.offsetPage += 1
    }
    
    func decrementPage() {
        self.offsetPage -= 1
        if self.offsetPage <= 0 {
            self.offsetPage = 1
        }
    }
}
