//
//  LiveResponse.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

typealias Quotes = Dictionary<String, Double>

struct LiveResponse: Codable {
    let success: Bool
    let terms: String?
    let privacy: String?
    let source: String?
    let timestamp: Int?
    let quotes: Quotes?
    let error: ApiLayerError?
}
