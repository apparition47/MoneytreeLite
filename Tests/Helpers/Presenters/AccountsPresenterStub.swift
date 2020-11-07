//
//  AccountsPresenterStub.swift
//  Tests
//
//  Created by Aaron Lee on 2020/11/07.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation
@testable import Currency

class AccountsPresenterStub: AccountsPresenter {
    var router: AccountsRouter
    
    var getNumberOfSections: Int = 0
    
    init (router: AccountsRouter) {
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func getNumberAccounts(in section: Int) -> Int {
        0
    }
    
    func getSectionHeader(section: Int) -> String {
        ""
    }
    
    func didSelectAccount(section: Int, row: Int) {
        
    }
    
    func configure(cell: AccountCell, forSection section: Int, forRow row: Int) {
        
    }
}
