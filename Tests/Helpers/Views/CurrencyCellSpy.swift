//
//  CurrencyCellSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class CurrencyCellSpy: CurrencyCellView {
    var displayedCurrCode = ""
    var displayedCurrDisplayName = ""
    
    func display(currCode: String, currDisplayName: String) {
        displayedCurrCode = currCode
        displayedCurrDisplayName = currDisplayName
    }
}
