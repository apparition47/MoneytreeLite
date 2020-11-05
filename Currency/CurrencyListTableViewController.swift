//
//  CurrencyListTableViewController.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit

final class CurrencyListTableViewController: UITableViewController {
	var presenter: CurrencyListPresenter!
	var configurator: CurrencyListConfigurator!
	
    
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configurator.configure(currencyListTableViewController: self)
		presenter.viewDidLoad()
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCurrencies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CurrencyCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

// MARK: - CurrencyListView

extension CurrencyListTableViewController: CurrencyListView {
    func refreshCurrencyListView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func displayCurrencyListError(title: String, message: String) {
        presentAlert(title: title, message: message)
    }
}
