//
//  Api.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/3.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//
import Alamofire
import SwiftyJSON

final class API {
    let host: String //
    
    init(host: String) {
        self.host = host
    }
    
    func fetch<R: APIRequest> (_ request: R, completion: @escaping (JSON) -> Void) {
        let headers: HTTPHeaders = [:] // 按需定制
        
        Alamofire
            .request(
                host + request.path,
                method: request.method,
                parameters: request.paramenters ?? nil,
                headers: headers
            )
            .responseJSON { response in
                guard let jsonStr = response.result.value else {
                    #if DEBUG
                    print("[API.fetch][\(request.path)]: No data.")
                    #endif
                    
                    return
                }
                
                let json = JSON(jsonStr)
                completion(json)
            }
    }
}



struct MyRequest: APIRequest {
    var path = "Promotion/getTabList"
    var method: HTTPMethod = .get
    var paramenters: Parameters? = nil
}

func demoRequest() {
    API(host:"https://api-plus.lhbgame.com/").fetch(MyRequest(paramenters: nil)) {res in
        print(res["info"]["data"][0])
    }
}

func testRquest() {
    Alamofire
        .request("https://api-plus.lhbgame.com/Promotion/getTabList?type=recent&page=2", method: .get)
        .responseJSON{ response in
            if let JSON = response.result.value {
                let res = JSON as! [String: Any]
                let info = res["info"] as! [String: Any]
                let data = info["data"] as! [[String: Any]]
                print(data[0])
            }
    }

}