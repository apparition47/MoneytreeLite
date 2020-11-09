//
//  TransactionsViewSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/09.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class TransactionsViewSpy: TransactionsView {
    var getTransactionsCalled = false
    var displayedTitle = ""
    
    func getTransactionsSuccess() {
        getTransactionsCalled = true
    }
    
    func displayTitle(title: String) {
        displayedTitle = title
    }
}
