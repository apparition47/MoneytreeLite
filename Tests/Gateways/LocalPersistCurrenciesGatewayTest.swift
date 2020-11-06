//
//  LocalPersistCurrenciesGatewayTest.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import XCTest
@testable import Currency

class LocalPersistCurrenciesGatewayTest: XCTestCase {
    var gateway: UserDefaultsCurrenciesGateway {
        UserDefaultsCurrenciesGateway()
    }
    
    func testSaveAndFetch() {
        let saveCompletionExpectation = expectation(description: "Save Accounts completion expectation")
        
        let url = Bundle.main.url(forResource: "accounts", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let jsonData = try! JSONDecoder().decode(GetAccountsResponse.self, from: data)
        let listToReturn = jsonData.accounts
        
        gateway.save(accounts: listToReturn) {
            self.gateway.getAccounts { result in
                guard case let .success(accounts) = result else {
                    XCTFail("Failed to load")
                    return
                }
                
                if listToReturn != accounts {
                    XCTFail("Failed to decode")
                }
                
                saveCompletionExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
