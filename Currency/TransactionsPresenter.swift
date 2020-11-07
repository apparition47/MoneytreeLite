//
//  TransactionsPresenter.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

protocol TransactionsPresenter {
    var router: TransactionsRouter { get }
    var getNumberOfSections: Int { get }
    func getNumberItems(in section: Int) -> Int
    func getSectionHeader(section: Int) -> String
    func viewDidLoad()
    func configure(cell: TransactionCell, forSection section: Int, forRow row: Int)
}

class TransactionsPresenterImplementation: TransactionsPresenter {
    private weak var view: TransactionsView?
    let getTransactionsUseCase: GetTransactionsUseCase
    let router: TransactionsRouter
    
    var account: Account!
    var transactions = [Transaction]() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMM")
            
            tableDataSource.removeAll()
            let grouped = Dictionary(grouping: transactions, by: {dateFormatter.string(from: $0.date)}).sorted(by: {$0.key > $1.key})
            for (key, value) in grouped {
                let sortedTrans = value.sorted(by: {$0.date > $1.date})
                self.tableDataSource.append(TableSection(header: key, items: sortedTrans))
            }
        }
    }
    // ordered by month, from the newest one to the oldest
    private var tableDataSource = [TableSection<Transaction>]()
    
    init(view: TransactionsView,
         account: Account,
         getTransactionsUseCase: GetTransactionsUseCase,
         router: TransactionsRouter) {
        self.view = view
        self.account = account
        self.getTransactionsUseCase = getTransactionsUseCase
        self.router = router
    }
    
    // MARK: - TransactionsPresenter
    
    var getNumberOfSections: Int {
        tableDataSource.count
    }
    
    func getNumberItems(in section: Int) -> Int {
        tableDataSource[section].items.count
    }
    
    func getSectionHeader(section: Int) -> String {
        tableDataSource[section].header
    }
    
    func viewDidLoad() {
        view?.displayTitle(title: "\(account.currentBalanceInBase) \(Constants.baseCurrency)")
        
        let params = GetTransactionsParams(accountId: account.id)
        getTransactionsUseCase.getTransactions(params: params) { [weak self] res in
            switch res {
            case .success(let transactions):
                self?.handleList(transactions)
            case .failure: break
            }
        }
    }
    
    func configure(cell: TransactionCell, forSection section: Int, forRow row: Int) {
        let meta = tableDataSource[section].items[row]
        cell.display(transaction: meta)
    }
    
    // MARK: - Private
    
    private func handleList(_ transactions: [Transaction]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.transactions = transactions
            DispatchQueue.main.async {
                self?.view?.getTransactionsSuccess()
            }
        }
    }
}
