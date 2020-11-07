//
//  AccountsViewSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/07.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class AccountsViewSpy: AccountsView {
    var getAccountsCalled = false
    var displayAccountsTotal: String?
    
    func getAccountsSuccess() {
        getAccountsCalled = true
    }
    
    func getAccountsTotalSuccess(total: String) {
        displayAccountsTotal = total
    }
}
