//
//  APIResource.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/3.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIResource {
    let raw: JSON?
    required init(raw: JSON?) {
        self.raw = raw
    }
}

// 基本扩展

extension APIResource {
    enum Status: String {
        case error
        case success = "success"
    }
    var status: Status? {
        return Status.init(rawValue: (raw?["response_status"].string)!)
    }
    
    var message: String? {
        return raw?["msg"].string
    }
    
    var extra: String? {
        return raw?["info"]["extra"].string
    }
    
    var data: JSON? {
        return raw?["info"]["data"]
    }
}
