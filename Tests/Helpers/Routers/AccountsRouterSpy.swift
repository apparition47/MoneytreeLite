//
//  AccountsRouterSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/07.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class AccountsRouterSpy: AccountsRouter {
    var passedAccount: Account?
    
    func presentTransactions(selected account: Account) {
        passedAccount = account
    }
}
