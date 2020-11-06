//
//  TransactionsConfigurator.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

protocol TransactionsConfigurator {
    func configure(_ transactionsViewController: TransactionsViewController)
}

class TransactionsConfiguratorImplementation: TransactionsConfigurator {
    let account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    func configure(_ transactionsViewController: TransactionsViewController) {
        let apiGateway = ApiCurrenciesGatewayImplementation()
        let localGateway = UserDefaultsCurrenciesGateway()
        let currencyGateway = CacheCurrenciesGateway(apiGateway: apiGateway, localPersistGateway: localGateway)
        
        let getTransactionsUseCase = GetTransactionsUseCaseImplementation(currenciesGateway: currencyGateway)
        let router = TransactionsRouterImplementation(transactionsViewController: transactionsViewController)
        let presenter = TransactionsPresenterImplementation(view: transactionsViewController, account: account, getTransactionsUseCase: getTransactionsUseCase, router: router)
        
        transactionsViewController.presenter = presenter
    }
}
