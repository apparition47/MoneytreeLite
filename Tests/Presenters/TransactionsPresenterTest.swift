//
//  TransactionsPresenterTest.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/09.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import XCTest
@testable import Currency

class TransactionsPresenterTest: XCTestCase {
    let getAccountsUseCaseSpy = GetTransactionsUseCaseSpy()
    let routerSpy = TransactionsRouterSpy()
    let viewSpy = TransactionsViewSpy()

    var presenter: TransactionsPresenterImplementation!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        let account = Account(id: 0, name: "", institution: "", currency: "", currentBalance: 0, currentBalanceInBase: 0)
        presenter = TransactionsPresenterImplementation(view: viewSpy, account: account, getTransactionsUseCase: getAccountsUseCaseSpy, router: routerSpy)
    }

    // MARK: - Tests

    func testGetTransactionsCalled() {
        // given
        let accountsToBeReturned = [Transaction]()
        getAccountsUseCaseSpy.resultToBeReturned = .success(accountsToBeReturned)
        
        // when
        presenter.viewDidLoad()
        
        stall(for: 0.1)

        // expected
        XCTAssertTrue(self.viewSpy.getTransactionsCalled, "getTransactions was not called")
    }
}
