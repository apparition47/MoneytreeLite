//
//  ConvertCurrenciesUseCase.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

typealias ConvertCurrenciesUseCaseCompletionHandler = (_ currencies: Result<[CurrencyRate]>) -> Void

struct ConvertCurrenciesParameters {
    let amount: Double
    let source: String
}

protocol ConvertCurrenciesUseCase {
    func convert(params: ConvertCurrenciesParameters, completion: @escaping ConvertCurrenciesUseCaseCompletionHandler)
}

class ConvertCurrenciesUseCaseImplementation: ConvertCurrenciesUseCase {
    
    let currenciesGateway: CurrenciesGateway
    
    init(currenciesGateway: CurrenciesGateway) {
        self.currenciesGateway = currenciesGateway
    }
    
    // MARK: - ConvertCurrenciesUseCase
    
    func convert(params: ConvertCurrenciesParameters, completion: @escaping ConvertCurrenciesUseCaseCompletionHandler) {
        self.currenciesGateway.live { result in
            switch result {
            case .success(let quotes):
                // double convert to USD to target because of free plan
                let usdAmt = 1 / (quotes["USD\(params.source)"] ?? 1)
                var converted = [CurrencyRate]()
                for (currCodeTarget, usdTargetRate) in quotes {
                    let targetRate = usdAmt * usdTargetRate
                    converted.append(CurrencyRate(
                        currPair: "\(params.source)\(currCodeTarget.suffix(3))",
                        rate: targetRate,
                        convertedAmount: targetRate * params.amount
                    ))
                }
                completion(.success(converted))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
