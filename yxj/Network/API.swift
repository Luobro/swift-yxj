//
//  MyAPI.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/5.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//


import Alamofire
import SwiftyJSON

func API(_ endPoint: EndPoint, _ parameters: Parameters?, completion: @escaping (JSON) -> Void) {
    let baseUrl = "https://api-plus.lhbgame.com"
    let (method, route, _) = endPoint.value
    
    Alamofire
        .request(
            baseUrl + route,
            method: method,
            parameters: parameters
    )
        .responseJSON { response in
            switch response.result {
                case .success(let resValue):
                    let data = JSON(resValue)["info"]["data"]
                    completion(data)
                case .failure(let error):
                    print("request failure",error)
            }
    }
}

enum EndPoint {
    case getPromotionList
    var value: (method: HTTPMethod, route: String, paramName: [String]) {
        switch self {
            case .getPromotionList:
                return (.get, "/Promotion/getTabList", ["type", "page"])
        }
    }
}


