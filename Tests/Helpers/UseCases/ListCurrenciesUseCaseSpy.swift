//
//  ListCurrenciesUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class ListCurrenciesUseCaseSpy: ListCurrenciesUseCase {
    var resultToBeReturned: Result<Currencies>!
    
    func list(completion: @escaping ListCurrenciesUseCaseCompletionHandler) {
        completion(resultToBeReturned)
    }
}
