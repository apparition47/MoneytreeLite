//
//  GetTransactionsApiRequest.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/05.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

struct GetTransactionsApiRequest: ApiCallRequest {
    let accountId: Int
    
    var path: String {
        "transactions_\(accountId)"
    }
}
