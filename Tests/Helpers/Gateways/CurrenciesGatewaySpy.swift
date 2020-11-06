//
//  CurrenciesGatewaySpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class CurrenciesGatewaySpy: CurrenciesGateway {
    var getAccountsResultToBeReturned: Result<[Account]>!
    var getTransactionsResultToBeReturned: Result<[Transaction]>!
    
    func getAccounts(completion: @escaping GetAccountsEntityGatewayCompletionHandler) {
        completion(getAccountsResultToBeReturned)
    }
    
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsEntityGatewayCompletionHandler) {
        completion(getTransactionsResultToBeReturned)
    }
    
    var liveCurrenciesResultToBeReturned: Result<Quotes>!
    var listCurrenciesResultToBeReturned: Result<Currencies>!
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        completion(liveCurrenciesResultToBeReturned)
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        completion(listCurrenciesResultToBeReturned)
    }
}
