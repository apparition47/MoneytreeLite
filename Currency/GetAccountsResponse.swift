//
//  GetAccountsResponse.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/05.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

struct GetAccountsResponse: Codable {
    let accounts: [Account]
}
