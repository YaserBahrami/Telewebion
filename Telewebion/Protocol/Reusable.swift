//
//  Reusable.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit

protocol Reusable {}

extension Reusable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
