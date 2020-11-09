//
//  GetTransactionsUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/09.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class GetTransactionsUseCaseSpy: GetTransactionsUseCase {
    var resultToBeReturned: Result<[Transaction]>!
    
    func getTransactions(params: GetTransactionsParams, completion: @escaping GetTransactionsUseCaseCompletionHandler) {
        completion(resultToBeReturned)
    }
}
