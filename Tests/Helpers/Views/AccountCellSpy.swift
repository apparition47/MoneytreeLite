//
//  AccountCellSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/07.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class AccountCellSpy: AccountCell {
    var displayedNickname = ""
    var displayedBalance = ""
    
    override func display(account: Account) {
        displayedNickname = account.name
        displayedBalance = "\(account.currentBalance) \(account.currency)"
    }
}
