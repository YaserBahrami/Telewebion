//
//  Result.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(value: T)
    case failure
}
