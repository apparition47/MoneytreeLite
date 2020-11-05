//
//  ApiCurrenciesGatewaySpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class ApiCurrenciesGatewaySpy: ApiCurrenciesGateway {
    var liveResultToBeReturned: Result<Quotes>!
    var listResultToBeReturned: Result<Currencies>!
    
    func live(completion: @escaping LiveCurrenciesEntityGatewayCompletionHandler) {
        completion(liveResultToBeReturned)
    }
    
    func list(completion: @escaping ListCurrenciesEntityGatewayCompletionHandler) {
        completion(listResultToBeReturned)
    }
}
