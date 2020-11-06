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
    let date: Date
    let description: String
    let id: Int
}

extension Transaction: Codable {

}

extension Transaction: Equatable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.id == rhs.id
    }
}
