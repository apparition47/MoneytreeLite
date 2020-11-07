//
//  GetAccountsUseCaseTest.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/07.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import XCTest
@testable import Currency

class GetAccountsUseCaseTest: XCTestCase {
    
    let gatewaySpy = CurrenciesGatewaySpy()
    
    var getAccountsUseCase: GetAccountsUseCaseImplementation!
    
    override func setUp() {
        super.setUp()
        getAccountsUseCase = GetAccountsUseCaseImplementation(currenciesGateway: gatewaySpy)
    }
    
    func testListSuccess() {
        let listResultToBeReturned = [Account]()
        let expectedResultToBeReturned: Result<[Account]> = Result.success(listResultToBeReturned)
        gatewaySpy.getAccountsResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "List Expectation")
        
        getAccountsUseCase.getAccounts { result in
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListFailure() {
        let expectedResultToBeReturned: Result<[Account]> = Result.failure(LocalError(message: "Failed to list"))
        gatewaySpy.getAccountsResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "List Expectation")
        
        getAccountsUseCase.getAccounts { result in
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
