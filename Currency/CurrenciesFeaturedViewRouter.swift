//
//  CurrenciesFeaturedViewRouter.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit

protocol CurrenciesFeaturedViewRouter: ViewRouter {
    func presentCurrenciesList(selected currency: String)
}

class CurrenciesFeaturedViewRouterImplementation: CurrenciesFeaturedViewRouter {
    struct Segue {
        static let CurrenciesFeaturedSceneToCurrencyListScene = "CurrenciesFeaturedSceneToCurrencyListSceneSegue"
    }
    
    fileprivate weak var currenciesFeaturedViewController: CurrenciesFeaturedViewController?
    fileprivate var currency: String!
    
    init(currenciesFeaturedViewController: CurrenciesFeaturedViewController) {
        self.currenciesFeaturedViewController = currenciesFeaturedViewController
    }
    
    // MARK: - CurrenciesViewRouter
    
    func presentCurrenciesList(selected currency: String) {
        self.currency = currency
        currenciesFeaturedViewController?.performSegue(withIdentifier: Segue.CurrenciesFeaturedSceneToCurrencyListScene, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CurrencyListTableViewController {
            vc.configurator = CurrencyListConfiguratorImplementation(currency: currency)
        }
    }
    
}

