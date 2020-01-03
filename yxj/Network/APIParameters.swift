//
//  APIParameters.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/3.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//

import Foundation
import Alamofire

protocol APIParameters {
    func toParameters() -> Parameters?
}

// 基本扩展
extension APIParameters {
    func toParameters() -> Parameters? {
        let paramDic = ModelToDic(model: self as AnyObject)
        return paramDic as? Parameters
    }
    
    /**
     对象转换为字典
     - parameter model: 对象
     - returns: 转化出来的字典
     */
    private func ModelToDic(model:AnyObject) -> NSDictionary{
        let redic = NSMutableDictionary()
        
        let mirror: Mirror = Mirror(reflecting: model)
        
        for p in mirror.children{
            if(p.label! != ""){
                redic.setValue("\(p.value)", forKey: p.label!)
            }
        }
        
        return redic
    }
}
