//
//  CurrencyListPresenterStub.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class CurrencyListPresenterStub: CurrencyListPresenter {
    var numberOfCurrencies: Int {
        return 0
    }
    
    var router: CurrencyListViewRouter
    
    init (router: CurrencyListViewRouter) {
        self.router = router
    }
    
    // TODO create spy
    
    func viewDidLoad() {
        
    }
    
    func configure(cell: CurrencyCellView, forRow row: Int) {
        
    }
    
    func didSelect(row: Int) {
        
    }
}
