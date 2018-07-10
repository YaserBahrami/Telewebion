//
//  DataModel.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataModel: NSObject{
    var id: Int?
    var title : String?
    var programTitle : String?
    var picture_path : String?

    required public init?(id: Int, title: String, programTitle: String, picture_path: String){
        self.id = id
        self.title = title
        self.programTitle = programTitle
        self.picture_path = picture_path
    }
    override public init() {
    }
    
    public func realmMapper(realmData: RealmDataModel) {
        id = realmData.id
        title = realmData.title
        programTitle = realmData.programTitle
        picture_path = realmData.picture_path
    }
    
}




