//
//  CurrencyRate.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

struct CurrencyRate {
    let currPair: String // USDCAD
    let rate: Double
    let convertedAmount: Double
}

extension CurrencyRate: Comparable {
    static func < (lhs: CurrencyRate, rhs: CurrencyRate) -> Bool {
        return lhs.currPair < rhs.currPair
    }
    
    static func == (lhs: CurrencyRate, rhs: CurrencyRate) -> Bool {
        return lhs.currPair == rhs.currPair
    }
}
