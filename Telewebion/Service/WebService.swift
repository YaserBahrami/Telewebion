//
//  WebService.swift
//  Telewebion
//
//  Created by yaser on 7/10/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class WebService{
    static let shared = WebService()
    private init() {}
    
    func getNewestPrograms(page: Int, callBack: @escaping (Result<[DataModel]>) -> Void){
        let url = "http://api.telewebion.com/v2/programs/getNewestPrograms?page=\(page)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                if response.response?.statusCode == 200{
                    let json = JSON(value)
                    let dataJson = json["data"]
                    
                    var successModel = [DataModel]()
                    if dataJson.count > 0{
                        for index in 0...(dataJson.count - 1){
                            let data = dataJson[index]
                            var programJson = data["program"]
                            
//                            print(data["title"].stringValue)
//                            print(programJson["title"].stringValue)
//                            print(data["picture_path"].stringValue)
//                            print("////")
                            let model = DataModel(id: data["id"].intValue ,title: data["title"].stringValue, programTitle: programJson["title"].stringValue, picture_path: data["picture_path"].stringValue)
                            successModel.append(model!)
                        }
                        callBack(Result.success(value: successModel))
                    }
                    
                    
                }
            case .failure(let error):
                print("\(error)")
                callBack(Result.failure)
            }
        }
        
    }
}
