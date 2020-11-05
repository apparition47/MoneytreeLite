//
//  CurrencyRateCell.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/19.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit
import Reusable

final class CurrencyRateCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

extension CurrencyRateCell: CurrencyRateCellView {
    func display(rate: CurrencyRate) {
        titleLabel.text = rate.currPair
        amountLabel.text = "Amt: \(rate.convertedAmount)"
        subtitleLabel.text = "\(rate.rate)"
    }
}
