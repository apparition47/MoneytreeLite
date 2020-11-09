//
//  CacheCurrenciesGatewayTest.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import XCTest
@testable import Currency

class CacheCurrenciesGatewayTest: XCTestCase {
    var apiGatewaySpy = ApiCurrenciesGatewaySpy()
    var localGatewaySpy = LocalPersistCurrenciesGatewaySpy()
    var cacheGateway: CacheCurrenciesGateway!
    
    override func setUp() {
        super.setUp()
        cacheGateway = CacheCurrenciesGateway(apiGateway: apiGatewaySpy, localPersistGateway: localGatewaySpy)
    }
    
    // MARK: - Tests
    
    func testGetAccountsCacheGetSuccess() {
        // given
        let jsonData = parse(jsonFile: "accounts", as: GetAccountsResponse.self)
        let listToReturn = jsonData.accounts
        
        let expectedResultToReturn: Result<[Account]> = .success(listToReturn)
        
        // when
        apiGatewaySpy.getAccountsResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get Accounts completion expectation")
        localGatewaySpy.getAccountsResultToBeReturned = expectedResultToReturn
        
        cacheGateway.getAccounts { res in
            // expected
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertEqual(listToReturn, self.localGatewaySpy.savedAccounts, "accounts weren't persisted")
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetTransactionsCacheGetSuccess() {
        // given
        let accountToLookupTransactions = GetTransactionsParams(accountId: 1)
        let jsonData = parse(jsonFile: "transactions_\(accountToLookupTransactions.accountId)", as: GetTransactionsResponse.self)
        let listToReturn = jsonData.transactions
        
        let expectedResultToReturn: Result<[Transaction]> = .success(listToReturn)
        
        // when
        apiGatewaySpy.getTransactionsResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get Transactions completion expectation")
        localGatewaySpy.getTransactionsResultToBeReturned = expectedResultToReturn
        
        cacheGateway.getTransactions(params: accountToLookupTransactions) { res in
            // expected
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertEqual(listToReturn, self.localGatewaySpy.savedTransactions, "transactions weren't persisted")
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetAccountsCacheGetFailure() {
        // given
        let expectedResultToReturn: Result<[Account]> = .failure(LocalError(message: "Error occurred"))
        
        apiGatewaySpy.getAccountsResultToBeReturned = expectedResultToReturn
        localGatewaySpy.getAccountsResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get Accounts completion expectation")
        
        // when
        cacheGateway.getAccounts { res in
            // expected
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertTrue(self.localGatewaySpy.getAccountsDidCalled, "get accounts wasn't called")
            
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
