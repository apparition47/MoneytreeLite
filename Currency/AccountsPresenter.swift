//
//  AccountsPresenter.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

protocol AccountsPresenter {
    var router: AccountsRouter { get }
    var getNumberOfSections: Int { get }
    func getNumberAccounts(in section: Int) -> Int
    func getSectionHeader(section: Int) -> String
    func viewDidLoad()
    func didSelectAccount(section: Int, row: Int)
    func configure(cell: AccountCell, forSection section: Int, forRow row: Int)
}

class AccountsPresenterImplementation: AccountsPresenter {
    private weak var view: AccountsView?
    let getAccountsUseCase: GetAccountsUseCase
    let router: AccountsRouter
    
    var accounts = [Account]() {
        didSet {
            tableDataSource.removeAll()
            let grouped = Dictionary(grouping: accounts, by: {$0.institution}).sorted(by: {$0.key < $1.key})
            for (key, value) in grouped {
                let sortedTrans = value.sorted(by: {$0.name < $1.name})
                self.tableDataSource.append(TableSection(header: key, items: sortedTrans))
            }
        }
    }
    // ordered by the account's nickname and grouped by its institution
    private var tableDataSource = [TableSection]()
    private struct TableSection {
        let header: String
        let items: [Account]
    }
    private var accountsTotal: Float = 0
    
    init(view: AccountsView,
         getAccountsUseCase: GetAccountsUseCase,
         router: AccountsRouter) {
        self.view = view
        self.getAccountsUseCase = getAccountsUseCase
        self.router = router
    }
    
    // MARK: - AccountsPresenter
    
    var getNumberOfSections: Int {
        tableDataSource.count
    }
    
    func getNumberAccounts(in section: Int) -> Int {
        tableDataSource[section].items.count
    }
    
    func getSectionHeader(section: Int) -> String {
        tableDataSource[section].header
    }
    
    func viewDidLoad() {
        getAccountsUseCase.getAccounts { [weak self] res in
            switch res {
            case .success(let accounts):
                self?.handleList(accounts)
            case .failure: break
            }
        }
        
        getAccountsUseCase.getAccountsTotal { [weak self] res in
            switch res {
            case .success(let total):
                self?.handleTotal(total)
            case .failure: break
            }
        }
    }
    
    func didSelectAccount(section: Int, row: Int) {
        let account = tableDataSource[section].items[row]
        router.presentTransactions(selected: account)
    }
    
    func configure(cell: AccountCell, forSection section: Int, forRow row: Int) {
        let meta = tableDataSource[section].items[row]
        cell.display(account: meta)
    }
    
    // MARK: - Private
    
    private func handleList(_ accounts: [Account]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.accounts = accounts
            DispatchQueue.main.async {
                self?.view?.getAccountsSuccess()
            }
        }
    }
    
    private func handleTotal(_ accountsTotal: Float) {
        self.accountsTotal = accountsTotal
        view?.getAccountsTotalSuccess(total: "\(accountsTotal) \(Constants.baseCurrency)")
    }
}
