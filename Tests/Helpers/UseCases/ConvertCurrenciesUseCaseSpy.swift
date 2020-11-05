
//
//  ConvertCurrenciesUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class ConvertCurrenciesUseCaseSpy: ConvertCurrenciesUseCase {
    
    var resultToBeReturned: Result<[CurrencyRate]>!
    
    func convert(params: ConvertCurrenciesParameters, completion: @escaping ConvertCurrenciesUseCaseCompletionHandler) {
        completion(resultToBeReturned)
    }
}
