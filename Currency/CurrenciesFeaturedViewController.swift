//
//  CurrenciesFeaturedViewController.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit

final class CurrenciesFeaturedViewController: UIViewController {
    var configurator = CurrenciesFeaturedConfiguratorImplementation(currency: "USD")
    var presenter: CurrenciesFeaturedPresenter!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencySelectorButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(currenciesFeaturedViewController: self)
        amountTextField.addTarget(self, action: #selector(amountTextFieldDidChange), for: .editingChanged)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - IBAction
    @IBAction func currencySelectorPressed(_ sender: Any) {
        presenter.didPressCurrencySelector()
    }
    
    @IBAction func unwindToFeatured(segue: UIStoryboardSegue) {
        viewDidLoad()
    }
    
    @objc private func amountTextFieldDidChange() {
        presenter.amountFieldChanged(amountTextField.text ?? "")
    }
    
}

extension CurrenciesFeaturedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCurrencies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CurrencyRateCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }

}

// MARK: - CurrenciesFeaturedView

extension CurrenciesFeaturedViewController: CurrenciesFeaturedView {
    func displaySelectedCurrency(currency: String) {
        currencySelectorButton.setTitle(currency, for: .normal)
    }
    
    func refreshCurrenciesView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
    func displayCurrenciesRetrievalError(title: String, message: String) {
        presentAlert(title: title, message: message)
    }
}
