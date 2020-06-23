//
//  GuruNaviError.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

/// ぐるなびWebサービス共通のエラーレスポンス
struct GuruNaviErrorResponse: Decodable {
    var error: [GuruNaviError]
}

struct GuruNaviError: Decodable {
    var code: Int
    var message: String?
}
