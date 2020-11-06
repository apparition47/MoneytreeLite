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
        let url = Bundle.main.url(forResource: "accounts", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let jsonData = try! JSONDecoder().decode(GetAccountsResponse.self, from: data)
        let listToReturn = jsonData.accounts
        
        let expectedResultToReturn: Result<[Account]> = .success(listToReturn)
        
        apiGatewaySpy.getAccountsResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get Accounts completion expectation")
        localGatewaySpy.getAccountsResultToBeReturned = expectedResultToReturn
        
        cacheGateway.getAccounts { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertEqual(listToReturn, self.localGatewaySpy.savedAccounts, "accounts weren't persisted")
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetTransactionsCacheGetSuccess() {
        // given
        let accountToLookupTransactions = GetTransactionsParams(accountId: 1)
        
        let url = Bundle.main.url(forResource: "transactions_\(accountToLookupTransactions.accountId)", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let jsonData = try! JSONDecoder().decode(GetTransactionsResponse.self, from: data)
        let listToReturn = jsonData.transactions
        
        let expectedResultToReturn: Result<[Transaction]> = .success(listToReturn)
        
        // when
        apiGatewaySpy.getTransactionsResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get Transactions completion expectation")
        localGatewaySpy.getTransactionsResultToBeReturned = expectedResultToReturn
        
        cacheGateway.getTransactions(params: accountToLookupTransactions) { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertEqual(listToReturn, self.localGatewaySpy.savedTransactions, "transactions weren't persisted")
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetAccountsCacheGetFailure() {
        let expectedResultToReturn: Result<[Account]> = .failure(LocalError(message: "Error occurred"))
        
        apiGatewaySpy.getAccountsResultToBeReturned = expectedResultToReturn
        localGatewaySpy.getAccountsResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get Accounts completion expectation")
        
        cacheGateway.getAccounts { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertTrue(self.localGatewaySpy.getAccountsDidCalled, "get accounts wasn't called")
            
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
