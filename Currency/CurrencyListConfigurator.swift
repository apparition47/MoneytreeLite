//
//  CurrencyListConfigurator.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

protocol CurrencyListConfigurator {
	func configure(currencyListTableViewController: CurrencyListTableViewController)
}

class CurrencyListConfiguratorImplementation: CurrencyListConfigurator {
	let currency: String
	
	init(currency: String) {
		self.currency = currency
	}
	
	func configure(currencyListTableViewController: CurrencyListTableViewController) {
        let apiGateway = ApiCurrenciesGatewayImplementation()
        let localGateway = UserDefaultsCurrenciesGateway()
        let currencyGateway = CacheCurrenciesGateway(apiGateway: apiGateway, localPersistGateway: localGateway)
		let router = CurrencyListViewRouterImplementation(currencyListTableViewController: currencyListTableViewController)
		let listCurrenciesUseCase = ListCurrenciesUseCaseImplementation(currenciesGateway: currencyGateway)
        let presenter = CurrencyListPresenterImplementation(view: currencyListTableViewController, listCurrenciesUseCase: listCurrenciesUseCase, currency: currency, router: router)

		currencyListTableViewController.presenter = presenter
	}
}
