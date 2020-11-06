//
//  TransactionsRouter.swift
//  Currency
//
//  Created by Aaron Lee on 2020/11/06.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import UIKit

protocol TransactionsRouter: ViewRouter {

}

class TransactionsRouterImplementation: TransactionsRouter {
    fileprivate weak var transactionsViewController: TransactionsViewController?
    
    init(transactionsViewController: TransactionsViewController) {
        self.transactionsViewController = transactionsViewController
    }
    
    // MARK: - TransactionsRouter
}
