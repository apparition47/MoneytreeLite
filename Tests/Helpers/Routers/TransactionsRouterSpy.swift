//
//  TransactionsRouterSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/09.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class TransactionsRouterSpy: TransactionsRouter {
    var passedAccount: Account?
    
    func presentTransactions(selected account: Account) {
        passedAccount = account
    }
}
