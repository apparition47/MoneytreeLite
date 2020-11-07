//
//  LocalPersistCurrenciesGatewaySpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class LocalPersistCurrenciesGatewaySpy: LocalPersistenceCurrenciesGateway {
    var savedAccounts: [Account]!
    var savedTransactions: [Transaction]!
    
    var getAccountsDidCalled = false
    var getTransactionsDidCalled = false
    var getTransactionParams: GetTransactionsParams!
    var getAccountsResultToBeReturned: Result<[Account]>!
    var getTransactionsResultToBeReturned: Result<[Transaction]>!
    
    // MARK: - LocalPersistenceCurrenciesGateway
    
    func save(accounts: [Account], completion: @escaping () -> Void) {
        savedAccounts = accounts
        completion()
    }
    
    func save(params: GetTransactionsParams, transactions: [Transaction], completion: @escaping () -> Void) {
        savedTransactions = transactions
        completion()
    }
    
    // MARK: - CurrenciesGateway
    
    func getAccounts(completion: @escaping GetAccountsEntityGatewayCompletionHandler) {
        getAccountsDidCalled = true
        completion(getAccountsResultToBeReturned)
    }
    
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsEntityGatewayCompletionHandler) {
        getTransactionsDidCalled = true
        getTransactionParams = params
        completion(getTransactionsResultToBeReturned)
    }
}
