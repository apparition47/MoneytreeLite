//
//  Account.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/05.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

struct Account {
    let id: Int
    let name: String
    let institution: String
    let currency: String
    let currentBalance: Float
    let currentBalanceInBase: Float
}

extension Account: Codable {

}

extension Account: Equatable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.id == rhs.id
    }
}
