//
//  RealmDataModel.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmDataModel: Object{
    @objc public dynamic var id = 0
    @objc public dynamic var title = ""
    @objc public dynamic var programTitle = ""
    @objc public dynamic var picture_path = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

