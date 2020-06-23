//
//  GAreaLargeSearchResponse.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Foundation

struct Areas: Decodable {
    let gareaLarge: [GareaLarge]
}

struct GareaLarge: Decodable {
    let areacodeL: String
    let areanameL: String
}
