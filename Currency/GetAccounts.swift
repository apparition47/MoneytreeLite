//
//  GetAccounts.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

typealias GetAccountsUseCaseCompletionHandler = (_ currencies: Result<[Account]>) -> Void
typealias GetAccountsTotalUseCaseCompletionHandler = (_ currencies: Result<Float>) -> Void

protocol GetAccountsUseCase {
    func getAccounts(completion: @escaping GetAccountsUseCaseCompletionHandler)
    func getAccountsTotal(completion: @escaping GetAccountsTotalUseCaseCompletionHandler)
}

class GetAccountsUseCaseImplementation: GetAccountsUseCase {
    
    let currenciesGateway: CurrenciesGateway
    
    init(currenciesGateway: CurrenciesGateway) {
        self.currenciesGateway = currenciesGateway
    }
    
    // MARK: - GetAccountsUseCase
    
    func getAccounts(completion: @escaping GetAccountsUseCaseCompletionHandler) {
        self.currenciesGateway.getAccounts { result in
            completion(result)
        }
    }
    
    func getAccountsTotal(completion: @escaping GetAccountsTotalUseCaseCompletionHandler) {
        self.currenciesGateway.getAccounts { result in
            switch result {
            case .success(let accounts):
                let sum = accounts.reduce(0) { (sum, account) -> Float in
                    return sum + account.currentBalanceInBase
                }
                completion(.success(sum))
            case .failure:
                break
//                completion(.failure(Error())
            }
        }
    }
}
