//
//  CacheCurrenciesGateway.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

private let UserDefaultsCacheTimestampKey = "UserDefaultsCacheTimestampKey"

class CacheCurrenciesGateway: CurrenciesGateway {
    let apiGateway: ApiCurrenciesGateway
    let localPersistGateway: LocalPersistenceCurrenciesGateway

    var shouldRefresh: Bool {
        let now = Date().timeIntervalSince1970
        let lastFetch = UserDefaults.standard.double(forKey: UserDefaultsCacheTimestampKey)
        if now >= (lastFetch + Constants.cacheLifetimeDuration) {
            UserDefaults.standard.set(now, forKey: UserDefaultsCacheTimestampKey)
            return true
        }
        return false
    }
    
    init(apiGateway: ApiCurrenciesGateway, localPersistGateway: LocalPersistenceCurrenciesGateway) {
        self.apiGateway = apiGateway
        self.localPersistGateway = localPersistGateway
    }
    
    // MARK: - CurrenciesGateway
    
    func getAccounts(completion: @escaping GetAccountsEntityGatewayCompletionHandler) {
        apiGateway.getAccounts { [weak self] result in
            switch result {
            case let .success(accounts):
                self?.localPersistGateway.save(accounts: accounts) {
                    completion(result)
                }
            case .failure:
                self?.localPersistGateway.getAccounts(completion: completion)
            }
        }
    }
    
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsEntityGatewayCompletionHandler) {
        apiGateway.getTransactions(params: params) { [weak self] result in
            switch result {
            case let .success(transactions):
                self?.localPersistGateway.save(params: params, transactions: transactions) {
                    completion(result)
                }
            case .failure:
                self?.localPersistGateway.getTransactions(params: params, completion: completion)
            }
        }
    }
}
