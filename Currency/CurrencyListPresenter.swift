//
//  CurrencyListPresenter.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//


import Foundation

protocol CurrencyListView: class {
    func refreshCurrencyListView()
    func displayCurrencyListError(title: String, message: String)
}

protocol CurrencyCellView {
    func display(currCode: String, currDisplayName: String)
}

protocol CurrencyListPresenter {
    var numberOfCurrencies: Int { get }
	var router: CurrencyListViewRouter { get }
	func viewDidLoad()
    func configure(cell: CurrencyCellView, forRow row: Int)
    func didSelect(row: Int)
}

class CurrencyListPresenterImplementation: CurrencyListPresenter {
	fileprivate var currency: String
	let router: CurrencyListViewRouter
    fileprivate let listCurrenciesUseCase: ListCurrenciesUseCase
	fileprivate weak var view: CurrencyListView?
    var currencyNames = [String]()
    var currencyCodes = [String]()
    
	init(view: CurrencyListView,
         listCurrenciesUseCase: ListCurrenciesUseCase,
	     currency: String,
	     router: CurrencyListViewRouter) {
		self.view = view
        self.listCurrenciesUseCase = listCurrenciesUseCase
		self.currency = currency
		self.router = router
	}
	
    // MARK: - CurrencyListPresenter
    
    var numberOfCurrencies: Int {
        return currencyNames.count
    }
    
    func configure(cell: CurrencyCellView, forRow row: Int) {
        let displayName = currencyNames[row]
        let currCode = currencyCodes[row]
        cell.display(currCode: currCode, currDisplayName: displayName)
    }
    
    func didSelect(row: Int) {
        let currCode = currencyCodes[row]
        router.presentFeatured(with: currCode)
    }
    
	func viewDidLoad() {
        listCurrenciesUseCase.list { [weak self] result in
            switch result {
            case let .success(currencies):
                self?.handleList(currencies)
            case let .failure(error):
                self?.view?.displayCurrencyListError(title: "Error", message: error.localizedDescription)
            }
        }
	}
    
    // MARK: - Private
    private func handleList(_ currencies: Currencies) {
        for (key, value) in currencies {
            currencyCodes.append(key)
            currencyNames.append(value)
        }
        view?.refreshCurrencyListView()
    }
}
