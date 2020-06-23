//
//  GuruNaviParamsBuilder.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation
import Keys

/// ぐるなびWebサービス共通のリクエストパラメータ
enum GuruNaviParamsBuilder {
    static func build() -> [String: Any] {
        let params: [String: Any] = ["keyid": GuruSearchKeys().guruNaviAPIKeyId]
        return params
    }
}
