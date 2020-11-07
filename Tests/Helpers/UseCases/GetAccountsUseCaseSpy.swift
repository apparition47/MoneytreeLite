//
//  GetAccountsUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/07.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class GetAccountsUseCaseSpy: GetAccountsUseCase {
    var resultToBeReturned: Result<[Account]>!
    var totalsResultToBeReturned: Result<Float>!
    
    func getAccounts(completion: @escaping GetAccountsUseCaseCompletionHandler) {
        completion(resultToBeReturned)
    }
    
    func getAccountsTotal(completion: @escaping GetAccountsTotalUseCaseCompletionHandler) {
        completion(totalsResultToBeReturned)
    }
}
