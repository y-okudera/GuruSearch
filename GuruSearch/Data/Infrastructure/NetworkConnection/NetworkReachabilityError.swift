//
//  NetworkReachabilityError.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

enum NetworkReachabilityError: Error {
    case notReachable
    case onlyViaWiFi
}

extension NetworkReachabilityError: LocalizedError {

    /// - Note: 各ケースのメッセージはダイアログで使えるようにするためにローカライズのキーだけ決めておくから、stringsファイルで定義してね
    var errorDescription: String? {
        switch self {
            case .notReachable:
                return "NotReachable".localized()
            case .onlyViaWiFi:
                return "OnlyViaWiFi".localized()
        }
    }
}
