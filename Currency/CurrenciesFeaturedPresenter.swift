//
//  CurrenciesFeaturedPresenter.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

protocol CurrenciesFeaturedView: class {
    func refreshCurrenciesView()
    func displayCurrenciesRetrievalError(title: String, message: String)
    func displaySelectedCurrency(currency: String)
}

protocol CurrencyRateCellView {
    func display(rate: CurrencyRate)
}

protocol CurrenciesFeaturedPresenter {
    var numberOfCurrencies: Int { get }
    var router: CurrenciesFeaturedViewRouter { get }
    func viewDidLoad()
    func didPressCurrencySelector()
    func amountFieldChanged(_ amount: String)
    func configure(cell: CurrencyRateCell, forRow row: Int)
}

class CurrenciesFeaturedPresenterImplementation: CurrenciesFeaturedPresenter {
    fileprivate weak var view: CurrenciesFeaturedView?
    fileprivate let getCurrenciesUseCase: ConvertCurrenciesUseCase
    internal let router: CurrenciesFeaturedViewRouter
    
    var currencyRates = [CurrencyRate]()
    
    private var currentAmount: Double = 1.0
    private var currentCurrency: String!
    private var refreshTimer: Timer?
    
    var numberOfCurrencies: Int {
        return currencyRates.count
    }
    
    init(view: CurrenciesFeaturedView,
         currency: String,
         getCurrenciesUseCase: ConvertCurrenciesUseCase,
         router: CurrenciesFeaturedViewRouter) {
        self.view = view
        self.currentCurrency = currency
        self.getCurrenciesUseCase = getCurrenciesUseCase
        self.router = router
    }
    
    
    // MARK: - CurrenciesPresenter
    
    func viewDidLoad() {
        view?.displaySelectedCurrency(currency: currentCurrency)
        fetchCurrencies()
        refreshTimer = Timer.scheduledTimer(timeInterval: Constants.cacheLifetimeDuration, target: self, selector: #selector(fetchCurrencies), userInfo: nil, repeats: true)
    }
    
    func didPressCurrencySelector() {
        router.presentCurrenciesList(selected: currentCurrency)
    }
    
    func amountFieldChanged(_ amount: String) {
        currentAmount = Double(amount) ?? 1.0
        fetchCurrencies()
    }
    
    func configure(cell: CurrencyRateCell, forRow row: Int) {
        let rate = currencyRates[row]
        cell.display(rate: rate)
    }
    
    
    // MARK: - Private
    @objc private func fetchCurrencies() {
        let params = ConvertCurrenciesParameters(amount: currentAmount, source: currentCurrency)
        getCurrenciesUseCase.convert(params: params) { [weak self] result in
            switch result {
            case let .success(currencies):
                self?.handleCurrenciesReceived(currencies)
            case let .failure(error):
                self?.handleCurrenciesError(error)
            }
        }
    }
    
    fileprivate func handleCurrenciesReceived(_ currencies: [CurrencyRate]) {
        self.currencyRates = currencies.sorted()
        view?.refreshCurrenciesView()
    }
    
    fileprivate func handleCurrenciesError(_ error: Error) {
        view?.displayCurrenciesRetrievalError(title: "Error", message: error.localizedDescription)
    }
}
