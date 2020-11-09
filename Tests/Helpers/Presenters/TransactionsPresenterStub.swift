//
//  TransactionsPresenterStub.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/09.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class TransactionsPresenterStub: TransactionsPresenter {
    var router: TransactionsRouter
    
    var getNumberOfSections: Int { 0 }
    
    init (router: TransactionsRouter) {
        self.router = router
    }
    
    func getNumberItems(in section: Int) -> Int {
        0
    }
    
    func getSectionHeader(section: Int) -> String {
        ""
    }
    
    func viewDidLoad() {
        
    }
    
    func configure(cell: TransactionCell, forSection section: Int, forRow row: Int) {
        
    }
}
