//
//  Transaction.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/05.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

struct Transaction {
    let accountId: Int
    let amount: String
    let categoryId: String
    let date: String
    let description: String
    let id: Int
}

extension Transaction: Codable {
    enum CodingKeys: String, CodingKey {
        case amount, date, id, description
        case accountId = "account_id"
        case categoryId = "category_id"
    }
}
