//
//  ListResponse.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

typealias Currencies = Dictionary<String, String>

struct ListResponse: Codable {
    let success: Bool
    let terms: String?
    let privacy: String?
    let currencies: Currencies?
    let error: ApiLayerError?
}
