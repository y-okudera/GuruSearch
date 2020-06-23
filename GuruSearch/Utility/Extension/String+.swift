//
//  String+.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

extension String {

    func localized() -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString
    }

    func toURL() -> URL {
        guard let url = URL.init(string: self) else {
            fatalError("Failed to convert String to URL.")
        }
        return url
    }
}
