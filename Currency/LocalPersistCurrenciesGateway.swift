//
//  LocalPersistCurrenciesGateway.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation


private let UserDefaultsAccountsKey = "UserDefaultsAccountsKey"
private func UserDefaultsTransactionsKey(accountId: Int) -> String { "UserDefaultsTransactionsKey\(accountId)" }

protocol LocalPersistenceCurrenciesGateway: CurrenciesGateway {
    func save(accounts: [Account], completion: @escaping () -> Void)
    func save(params: GetTransactionsParams, transactions: [Transaction], completion: @escaping () -> Void)
}

class UserDefaultsCurrenciesGateway: LocalPersistenceCurrenciesGateway {

    // MARK: - ApiCurrenciesGateway
    
    func getAccounts(completion: @escaping GetAccountsEntityGatewayCompletionHandler) {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsAccountsKey) as? Data,
            let obj = try? JSONDecoder().decode([Account].self, from: data) {
            completion(.success(obj))
        } else {
            completion(.failure(LocalError(message: "\(UserDefaultsAccountsKey) not found")))
        }
    }
    
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsEntityGatewayCompletionHandler) {
        let key = UserDefaultsTransactionsKey(accountId: params.accountId)
        if let data = UserDefaults.standard.value(forKey: key) as? Data,
            let obj = try? JSONDecoder().decode([Transaction].self, from: data) {
            completion(.success(obj))
        } else {
            completion(.failure(LocalError(message: "\(key) not found")))
        }
    }
    
    // MARK: - LocalPersistenceCurrenciesGateway
    
    func save(accounts: [Account], completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let data = try? JSONEncoder().encode(accounts) {
                UserDefaults.standard.set(data, forKey: UserDefaultsAccountsKey)
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func save(params: GetTransactionsParams, transactions: [Transaction], completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let data = try? JSONEncoder().encode(transactions) {
                let key = UserDefaultsTransactionsKey(accountId: params.accountId)
                UserDefaults.standard.set(data, forKey: key)
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
