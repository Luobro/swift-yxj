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
/**
待补充
 */
extension APIResource {
    enum Status: String {
        case error
        case success
    }
    var status: Status? {
        return Status.init(rawValue: (raw?["status"].string)!)
    }
    
    var message: String? {
        return raw?["message"].string
    }
}
