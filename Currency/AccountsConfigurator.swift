//
//  AccountsConfigurator.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

protocol AccountsConfigurator {
    func configure(_ accountsViewController: AccountsViewController)
}

class AccountsConfiguratorImplementation: AccountsConfigurator {
    func configure(_ accountsViewController: AccountsViewController) {
        let apiGateway = ApiCurrenciesGatewayImplementation()
        let localGateway = UserDefaultsCurrenciesGateway()
        let currencyGateway = CacheCurrenciesGateway(apiGateway: apiGateway, localPersistGateway: localGateway)
        
        let getAccountsUseCase = GetAccountsUseCaseImplementation(currenciesGateway: currencyGateway)
        let router = AccountsRouterImplementation(accountsViewController: accountsViewController)
        let presenter = AccountsPresenterImplementation(view: accountsViewController, getAccountsUseCase: getAccountsUseCase, router: router)
        
        accountsViewController.presenter = presenter
    }
}
