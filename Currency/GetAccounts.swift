//
//  GetAccounts.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

typealias GetAccountsUseCaseCompletionHandler = (_ currencies: Result<[Account]>) -> Void

protocol GetAccountsUseCase {
    func getAccounts(completion: @escaping GetAccountsUseCaseCompletionHandler)
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
}
