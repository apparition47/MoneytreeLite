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

    var savedList: Currencies!
    var savedLive: Quotes!
    
    var getLiveDidCalled = false
    var getListDidCalled = false
    var liveResultToBeReturned: Result<Quotes>!
    var listResultToBeReturned: Result<Currencies>!
    
    // MARK: - LocalPersistenceCurrenciesGateway
    
    func save(list: Currencies) {
        savedList = list
    }
    
    func save(live: Quotes) {
        savedLive = live
    }
    
    // MARK: - CurrenciesGateway
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        getLiveDidCalled = true
        completion(liveResultToBeReturned)
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        getListDidCalled = true
        completion(listResultToBeReturned)
    }
    
    var savedAccounts: [Account]!
    var savedTransactions: [Transaction]!
    
    var getAccountsDidCalled = false
    var getTransactionsDidCalled = false
    var getTransactionParams: GetTransactionsParams!
    var getAccountsResultToBeReturned: Result<[Account]>!
    var getTransactionsResultToBeReturned: Result<[Transaction]>!
    
    func save(accounts: [Account], completion: @escaping () -> Void) {
        savedAccounts = accounts
        completion()
    }
    
    func save(params: GetTransactionsParams, transactions: [Transaction], completion: @escaping () -> Void) {
        savedTransactions = transactions
        completion()
    }
    
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
