//
//  GetTransactions.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/05.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

typealias GetTransactionsUseCaseCompletionHandler = (_ currencies: Result<[Transaction]>) -> Void

struct GetTransactionsParams {
    let accountId: Int
}

protocol GetTransactionsUseCase {
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsUseCaseCompletionHandler)
}

class GetTransactionsUseCaseImplementation: GetTransactionsUseCase {
    
    let currenciesGateway: CurrenciesGateway
    
    init(currenciesGateway: CurrenciesGateway) {
        self.currenciesGateway = currenciesGateway
    }
    
    // MARK: - GetTransactionsUseCase
    
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsUseCaseCompletionHandler) {
        self.currenciesGateway.getTransactions(params: params) { result in
            completion(result)
        }
    }
}
