//
//  AccountsPresenterTest.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/07.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import XCTest
@testable import Currency

class AccountsPresenterTest: XCTestCase {
    let getAccountsUseCaseSpy = GetAccountsUseCaseSpy()
    let routerSpy = AccountsRouterSpy()
    let viewSpy = AccountsViewSpy()

    var presenter: AccountsPresenterImplementation!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        presenter = AccountsPresenterImplementation(view: viewSpy, getAccountsUseCase: getAccountsUseCaseSpy, router: routerSpy)
    }

    // MARK: - Tests

    func testGetAccountsCalled() {
        // given
        let accountsToBeReturned = [Account]()
        let accountsTotalToBeReturned: Float = 10
        getAccountsUseCaseSpy.resultToBeReturned = .success(accountsToBeReturned)
        getAccountsUseCaseSpy.totalsResultToBeReturned = .success(accountsTotalToBeReturned)
        
        // when
        presenter.viewDidLoad()
        
        stall(for: 0.1)

        // expected
        XCTAssertTrue(self.viewSpy.getAccountsCalled, "getAccounts was not called")
    }
}
