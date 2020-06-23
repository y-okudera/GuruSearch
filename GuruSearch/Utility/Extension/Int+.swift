//
//  Int+.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let commaString = numberFormatter.string(from: NSNumber(value: self)) {
            return commaString
        }
        else {
            return "\(self)"
        }
    }
}
