//
//  RelaxedString.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

struct RelaxedString: Codable {
    let value: String

    init(_ value: String) {
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        // attempt to decode from all JSON primitives
        if let str = try? container.decode(String.self) {
            value = str
        } else if let int = try? container.decode(Int.self) {
            value = int.description
        } else if let double = try? container.decode(Double.self) {
            value = double.description
        } else if let bool = try? container.decode(Bool.self) {
            value = bool.description
        } else {
            throw DecodingError.typeMismatch(String.self, .init(codingPath: decoder.codingPath, debugDescription: ""))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
