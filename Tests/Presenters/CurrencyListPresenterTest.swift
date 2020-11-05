//
//  CurrencyListPresenterTest.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import XCTest
@testable import Currency

class CurrencyListPresenterTest: XCTestCase {
    
    let passedSelectedCurrency = "USD"
    let listUseCaseSpy = ListCurrenciesUseCaseSpy()
    let routerSpy = CurrencyListViewRouterSpy()
    let viewSpy = CurrencyListViewSpy()

    var presenter: CurrencyListPresenterImplementation!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        presenter = CurrencyListPresenterImplementation(view: viewSpy, listCurrenciesUseCase: listUseCaseSpy, currency: passedSelectedCurrency, router: routerSpy)
    }

    // MARK: - Tests

    func testRefreshListCalled() {
        let currenciesToBeReturned = Currencies()
        listUseCaseSpy.resultToBeReturned = .success(currenciesToBeReturned)
        presenter.viewDidLoad()
        XCTAssertTrue(viewSpy.refreshCurrencyListCalled, "refreshCurrencyListCalled was not called")
    }
}
