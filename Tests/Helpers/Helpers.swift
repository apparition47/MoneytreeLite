//
//  Helpers.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

extension Result: Equatable { }
public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    String(describing: lhs) == String(describing: rhs)
}

public func parse<T: Decodable>(jsonFile: String, as type: T.Type) -> T {
    let url = Bundle.main.url(forResource: jsonFile, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try! decoder.decode(T.self, from: data)
}
