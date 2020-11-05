//
//  ListCurrenciesUseCase.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

typealias ListCurrenciesUseCaseCompletionHandler = (_ currencies: Result<Currencies>) -> Void

struct ListCurrenciesParameters {
    let source: String
}

protocol ListCurrenciesUseCase {
    func list(completion: @escaping ListCurrenciesUseCaseCompletionHandler)
}

class ListCurrenciesUseCaseImplementation: ListCurrenciesUseCase {
    
    let currenciesGateway: CurrenciesGateway
    
    init(currenciesGateway: CurrenciesGateway) {
        self.currenciesGateway = currenciesGateway
    }
    
    // MARK: - ConvertCurrenciesUseCase
    
    func list(completion: @escaping ListCurrenciesUseCaseCompletionHandler) {
        self.currenciesGateway.list { result in
            completion(result)
        }
    }
}
