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
    
    func testListCacheGetSuccess() {
        let listToReturn = Currencies() // TODO use JSON stub insetad
        let expectedResultToReturn: Result<Currencies> = .success(listToReturn)
        
        apiGatewaySpy.listResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get List completion expectation")
        localGatewaySpy.listResultToBeReturned = expectedResultToReturn
        
        cacheGateway.list { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertEqual(listToReturn, self.localGatewaySpy.savedList, "list wasn't persisted")
            
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListCacheGetFailure() {
        let expectedResultToReturn: Result<Currencies> = .failure(LocalError(message: "Error occurred"))
        
        apiGatewaySpy.listResultToBeReturned = expectedResultToReturn
        localGatewaySpy.listResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get List completion expectation")
        
        cacheGateway.list { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            XCTAssertTrue(self.localGatewaySpy.getListDidCalled, "get list wasn't called")
            
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
