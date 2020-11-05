//
//  CurrencyListViewRouter.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit

protocol CurrencyListViewRouter: ViewRouter {
	func dismissView()
    func presentFeatured(with currency: String)
}

class CurrencyListViewRouterImplementation: CurrencyListViewRouter {
    struct Segue {
        static let CurrencyListSceneToCurrenciesFeaturedSceneSegue = "CurrencyListSceneToCurrenciesFeaturedSceneSegue"
    }
    
	fileprivate weak var currencyListTableViewController: CurrencyListTableViewController?
    fileprivate var currency: String!
	
	init(currencyListTableViewController: CurrencyListTableViewController) {
		self.currencyListTableViewController = currencyListTableViewController
	}
	
	func dismissView() {
		let _ = currencyListTableViewController?.navigationController?.popViewController(animated: true)
	}
    
    // MARK: - CurrenciesViewRouter
    
    func presentFeatured(with currency: String) {
        self.currency = currency
        currencyListTableViewController?.performSegue(withIdentifier: Segue.CurrencyListSceneToCurrenciesFeaturedSceneSegue, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CurrenciesFeaturedViewController {
            vc.configurator = CurrenciesFeaturedConfiguratorImplementation(currency: currency)
        }
    }
}
