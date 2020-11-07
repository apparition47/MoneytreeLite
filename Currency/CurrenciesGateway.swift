//
//  CurrenciesGateway.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

typealias GetAccountsEntityGatewayCompletionHandler = (_ transactions: Result<[Account]>) -> Void
typealias GetTransactionsEntityGatewayCompletionHandler = (_ transactions: Result<[Transaction]>) -> Void

protocol CurrenciesGateway {
    func getAccounts(completion: @escaping GetAccountsEntityGatewayCompletionHandler)
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsEntityGatewayCompletionHandler)
}
