//
//  AccountsRouter.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import UIKit

protocol AccountsRouter: ViewRouter {
    func presentTransactions(selected account: Account)
}

class AccountsRouterImplementation: AccountsRouter {
    struct Segue {
        static let AccountsSceneToTransactionsScene = "AccountsSceneToTransactionsSceneSegue"
    }
    
    fileprivate weak var accountsViewController: AccountsViewController?
    fileprivate var account: Account!
    
    init(accountsViewController: AccountsViewController) {
        self.accountsViewController = accountsViewController
    }
    
    // MARK: - CurrenciesViewRouter
    
    func presentTransactions(selected account: Account) {
        self.account = account
        accountsViewController?.performSegue(withIdentifier: Segue.AccountsSceneToTransactionsScene, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TransactionsViewController {
            vc.configurator = TransactionsConfiguratorImplementation(account: account)
        }
    }
    
}
