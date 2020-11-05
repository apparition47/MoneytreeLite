//
//  CurrencyListViewSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class CurrencyListViewSpy: CurrencyListView {
    var refreshCurrencyListCalled = false
    var displayCurrencyListErrorTitle: String?
    var displayCurrencyListErrorMessage: String?
    
    func refreshCurrencyListView() {
        refreshCurrencyListCalled = true
    }
    
    func displayCurrencyListError(title: String, message: String) {
        displayCurrencyListErrorTitle = title
        displayCurrencyListErrorMessage = message
    }
}
