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
        return UserDefaultsCurrenciesGateway()
    }
    
    func testSaveAndFetch() {
        let saveCompletionExpectation = expectation(description: "Save Quotes completion expectation")
        let obj = Currencies()
        gateway.save(list: obj)
        gateway.list { result in
            guard case let .success(quotes) = result else {
                XCTFail("Failed to load")
                return
            }
            
            if obj != quotes {
                XCTFail("Failed to decode")
            }
            
            saveCompletionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
