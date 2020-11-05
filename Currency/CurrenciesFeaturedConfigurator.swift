//
//  CurrenciesFeaturedConfigurator.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

protocol CurrenciesFeaturedConfigurator {
    func configure(currenciesFeaturedViewController: CurrenciesFeaturedViewController)
}

class CurrenciesFeaturedConfiguratorImplementation: CurrenciesFeaturedConfigurator {
    let currency: String
    
    init(currency: String) {
        self.currency = currency
    }
    
    func configure(currenciesFeaturedViewController: CurrenciesFeaturedViewController) {
        let apiGateway = ApiCurrenciesGatewayImplementation()
        let localGateway = UserDefaultsCurrenciesGateway()
        let currencyGateway = CacheCurrenciesGateway(apiGateway: apiGateway, localPersistGateway: localGateway)
        
        let convertCurrenciesUseCase = ConvertCurrenciesUseCaseImplementation(currenciesGateway: currencyGateway)
        let router = CurrenciesFeaturedViewRouterImplementation(currenciesFeaturedViewController: currenciesFeaturedViewController)
        
        let presenter = CurrenciesFeaturedPresenterImplementation(view: currenciesFeaturedViewController, currency: currency, getCurrenciesUseCase: convertCurrenciesUseCase, router: router)
        
        currenciesFeaturedViewController.presenter = presenter
    }
}
