//
//  ApiRequest.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation

protocol ApiCallRequest {
    var baseURL: String { get }
    var params: [String: Any] { get }
    var path: String { get }
}

extension ApiCallRequest {
    var baseURL: String {
        "http://apilayer.net/api"
    }
    
    var params: [String: Any] {
        [String: Any]()
    }
}
