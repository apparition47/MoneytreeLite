//
//  TransactionsViewController.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import UIKit

protocol TransactionsView: class {
    func getTransactionsSuccess()
    func displayTitle(title: String)
}

class TransactionsViewController: UITableViewController {
    var configurator: TransactionsConfiguratorImplementation!
    var presenter: TransactionsPresenter!
    
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

extension TransactionsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getNumberOfSections
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.getSectionHeader(section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberItems(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionCell = tableView.dequeueReusableCell(for: indexPath)
        presenter.configure(cell: cell, forSection: indexPath.section, forRow: indexPath.row)
        return cell
    }
}

extension TransactionsViewController: TransactionsView {
    func getTransactionsSuccess() {
        tableView.reloadData()
    }
    
    func displayTitle(title: String) {
        self.title = title
    }
}
