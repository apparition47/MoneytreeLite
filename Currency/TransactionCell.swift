//
//  TransactionCell.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import UIKit
import Reusable

protocol TransactionCellView {
    func display(transaction: Transaction)
}

class TransactionCell: UITableViewCell, Reusable {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

extension TransactionCell: TransactionCellView {
    func display(transaction: Transaction) {
        amountLabel.text = "\(transaction.amount)"
        descriptionLabel.text = transaction.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyyMMdd")
        dateLabel.text = dateFormatter.string(from: transaction.date)
    }
}
