//
//  CurrenciesGateway.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

typealias LiveCurrenciesEntityGatewayCompletionHandler = (_ quotes: Result<Quotes>) -> Void
typealias ListCurrenciesEntityGatewayCompletionHandler = (_ currencies: Result<Currencies>) -> Void

typealias GetAccountsEntityGatewayCompletionHandler = (_ transactions: Result<[Account]>) -> Void
typealias GetTransactionsEntityGatewayCompletionHandler = (_ transactions: Result<[Transaction]>) -> Void

protocol CurrenciesGateway {
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler)
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler)

    func getAccounts(completion: @escaping GetAccountsEntityGatewayCompletionHandler)
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsEntityGatewayCompletionHandler)
}
