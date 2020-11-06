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
    let amount: Float
    let categoryId: Int
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

extension Transaction: Equatable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.id == rhs.id
    }
}
