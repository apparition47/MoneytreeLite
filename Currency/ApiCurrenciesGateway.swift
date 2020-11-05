//
//  ApiCurrenciesGateway.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation


protocol ApiCurrenciesGateway: CurrenciesGateway {

}

class ApiCurrenciesGatewayImplementation: ApiCurrenciesGateway {

    // MARK: - ApiCurrenciesGateway
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        let req = LiveCurrenciesApiRequest()
        APIManager.execute(request: req, completion: { (result: LiveResponse) in
            guard result.success, let quotes = result.quotes else {
                let err = LocalError(message: result.error?.info ?? "Unknown error")
                completion(.failure(err))
                return
            }
            completion(.success(quotes))
        })
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        let req = ListCurrenciesApiRequest()
        APIManager.execute(request: req, completion: { (result: ListResponse) in
            guard result.success, let currencies = result.currencies else {
                let err = LocalError(message: result.error?.info ?? "Unknown error")
                completion(.failure(err))
                return
            }
            completion(.success(currencies))
        })
    }
    
    
    func getAccounts(completion: @escaping GetAccountsEntityGatewayCompletionHandler) {
        let req = GetAccountsApiRequest()
        APIManager.execute(request: req) { (result: GetAccountsResponse) in
//            guard result.success, let accounts = result.accounts else {
//                let err = LocalError(message: result.error?.info ?? "Unknown error")
//                completion(.failure(err))
//                return
//            }
            completion(.success(result.accounts))
        }
    }
    
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsEntityGatewayCompletionHandler) {
        let req = GetTransactionsApiRequest(accountId: params.accountId)
        APIManager.execute(request: req) { (result: GetTransactionsResponse) in
            completion(.success(result.transactions))
        }
    }
}
