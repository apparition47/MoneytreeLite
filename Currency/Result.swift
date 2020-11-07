//
//  Result.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

struct LocalError: Error {
    var localizedDescription: String {
        message
    }
    
    var message = ""
}

enum Result<T> {
	case success(T)
	case failure(Error)
}
