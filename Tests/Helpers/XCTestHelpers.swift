//
//  XCTestHelpers.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/09.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import XCTest

extension XCTestCase {
    // temp workaround for delegate methods without callbacks
    func stall(for seconds: Double) {
        XCTWaiter().wait(for: [expectation(description: "test")], timeout: seconds)
    }
}
