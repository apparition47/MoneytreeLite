//
//  AccountsViewController.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import UIKit

protocol AccountsView: class {
    func getAccountsSuccess()
    func getAccountsTotalSuccess(total: String)
}

class AccountsViewController: UITableViewController {
    var configurator = AccountsConfiguratorImplementation()
    var presenter: AccountsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension AccountsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getNumberOfSections
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.getSectionHeader(section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberAccounts(in: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectAccount(section: indexPath.section, row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountCell = tableView.dequeueReusableCell(for: indexPath)
        presenter.configure(cell: cell, forSection: indexPath.section, forRow: indexPath.row)
        return cell
    }
    
}

// MARK: - AccountsView

extension AccountsViewController: AccountsView {
    func getAccountsSuccess() {
        tableView.reloadData()
    }
    
    func getAccountsTotalSuccess(total: String) {
        title = total
    }
}
