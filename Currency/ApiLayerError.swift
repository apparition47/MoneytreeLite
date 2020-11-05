//
//  ApiLayerError.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

struct ApiLayerError: Codable {
    let code: Int
    let info: String
}
