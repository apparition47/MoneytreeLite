//
//  GetTransactionsUseCaseTest.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/09.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import XCTest
@testable import Currency

class GetTransactionsUseCaseTest: XCTestCase {
    
    let gatewaySpy = CurrenciesGatewaySpy()
    
    var getTranscationsUseCase: GetTransactionsUseCaseImplementation!
    
    override func setUp() {
        super.setUp()
        getTranscationsUseCase = GetTransactionsUseCaseImplementation(currenciesGateway: gatewaySpy)
    }
    
    func testListSuccess() {
        // gien
        let accountId = 1
        let listResultToBeReturned = parse(jsonFile: "transactions_\(accountId)", as: GetTransactionsResponse.self).transactions
        let expectedResultToBeReturned: Result<[Transaction]> = Result.success(listResultToBeReturned)
        gatewaySpy.getTransactionsResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "List Expectation")
        
        let params = GetTransactionsParams(accountId: accountId)
        // when
        getTranscationsUseCase.getTransactions(params: params) { result in
            // expected
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListFailure() {
        // given
        let accountId = 1
        let expectedResultToBeReturned: Result<[Transaction]> = Result.failure(LocalError(message: "Failed to list"))
        gatewaySpy.getTransactionsResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "List Expectation")
        
        let params = GetTransactionsParams(accountId: accountId)
        // when
        getTranscationsUseCase.getTransactions(params: params) { result in
            // expected
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
