//
//  ViewRouter.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import UIKit

protocol ViewRouter {
	func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension ViewRouter {
	func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
