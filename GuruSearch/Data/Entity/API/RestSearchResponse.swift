//
//  RestSearchResponse.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

struct Restaurants: Decodable {
    var totalHitCount: Int
    var hitPerPage: Int
    var pageOffset: Int
    var rest: [Restaurant]
}

struct Restaurant: Decodable {
    var id: String?
    var name: String?
    var url: String?
    var imageUrl: ImageUrl
    var tel: String?
    var opentime: String?
    var access: Access
    var pr: PR
    /// 平均予算
    var budget: RelaxedString?

    struct ImageUrl: Decodable {
        var shopImage1: String?
        var shopImage2: String?
    }

    struct Access: Decodable {
        var line: String?
        var station: String?
        var stationExit: String?
        var walk: RelaxedString?
        var note: String?
    }

    struct PR: Decodable {
        var prShort: String?
        var prLong: String?
    }
}
