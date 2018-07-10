//
//  programCollectionViewCell.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit

class programCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var programTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var picture_path = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
