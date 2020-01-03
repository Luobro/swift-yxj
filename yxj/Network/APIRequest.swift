//
//  APIRequest.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/3.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequest {
//    associatedtype APIResourceType: APIResource
    
    var path: String { get }
    var method: HTTPMethod { get }
    var paramenters: Parameters? { get }
}
