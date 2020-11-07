//
//  ApiCurrenciesGatewaySpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class ApiCurrenciesGatewaySpy: ApiCurrenciesGateway {
    var getAccountsResultToBeReturned: Result<[Account]>!
    var getTransactionsResultToBeReturned: Result<[Transaction]>!
    
    var getTransactionParams: GetTransactionsParams!
    
    func getAccounts(completion: @escaping GetAccountsEntityGatewayCompletionHandler) {
        completion(getAccountsResultToBeReturned)
    }
    
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsEntityGatewayCompletionHandler) {
        getTransactionParams = params
        completion(getTransactionsResultToBeReturned)
    }
}
