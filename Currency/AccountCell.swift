//
//  AccountCell.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import UIKit
import Reusable

protocol AccountCellView {
    func display(account: Account)
}

class AccountCell: UITableViewCell, AccountCellView, Reusable {
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    func display(account: Account) {
        nicknameLabel.text = account.name
        balanceLabel.text = "\(account.currentBalance) \(account.currency)"
    }
}
