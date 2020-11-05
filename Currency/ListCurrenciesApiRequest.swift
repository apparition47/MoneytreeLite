//
//  ListCurrenciesApiRequest.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

struct ListCurrenciesApiRequest: ApiCallRequest {
    var path: String {
        return "list"
    }
}
