//
//  ConvertCurrenciesUseCaseTest.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import XCTest
@testable import Currency

class ConvertCurrenciesUseCaseTest: XCTestCase {
    
    let gatewaySpy = CurrenciesGatewaySpy()
    
    var listCurrenciesUseCase: ListCurrenciesUseCaseImplementation!
    
    override func setUp() {
        super.setUp()
        listCurrenciesUseCase = ListCurrenciesUseCaseImplementation(currenciesGateway: gatewaySpy)
    }
    
    func testListSuccess() {
        let listResultToBeReturned = Currencies()
        let expectedResultToBeReturned: Result<Currencies> = Result.success(listResultToBeReturned)
        gatewaySpy.listCurrenciesResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "List Expectation")
        
        listCurrenciesUseCase.list { result in
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListFailure() {
        let expectedResultToBeReturned: Result<Currencies> = Result.failure(LocalError(message: "Failed to list"))
        gatewaySpy.listCurrenciesResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "List Expectation")
        
        listCurrenciesUseCase.list { result in
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
