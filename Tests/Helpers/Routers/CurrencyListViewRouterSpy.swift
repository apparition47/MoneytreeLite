//
//  CurrencyListViewRouterSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class CurrencyListViewRouterSpy: CurrencyListViewRouter {
    var passedCurrency: String?
    var dismissViewCalled = false
    
    func dismissView() {
        dismissViewCalled = true
    }
    
    func presentFeatured(with currency: String) {
        passedCurrency = currency
    }
}
