//
//  CurrencyCell.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit
import Reusable

final class CurrencyCell: UITableViewCell, Reusable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
}

extension CurrencyCell: CurrencyCellView {
    func display(currCode: String, currDisplayName: String) {
        titleLabel.text = currCode
        subtitleLabel.text = currDisplayName // EN only
    }
}
