//
//  Collection.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ type: T.Type) where T: Reusable {
        let nib = UINib(nibName: type.identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: type.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(at index: IndexPath) -> T where T: Reusable {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: index) as! T
    }
}
