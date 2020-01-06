//
//  GoodsItem.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/4.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//
import Combine
import SwiftUI
import SwiftyJSON

struct GoodsItem {
    var cover: String?
    var title: String?
    var salePrice: Float?
    var discount: Int?
    var originPrice: Float?
    var plusPrice: Float?
    var plusDiscount: Int?
}

class GoodsList: ObservableObject {
    @Published var list:[GoodsItem] = []
    var page: Int = 1
    var type: String = "latest"
    var isLoding: Bool = false
    var lastPage:[GoodsItem] = []
    var hasMore: Bool {
        switch self.lastPage.count {
            case 1..<20:
                return false
            default:
                return true
        }
    }

    init(type: String = "latest") {
        self.type = type
        loadData()
    }
    
    func parseRaw(_ rawData: JSON?)->[GoodsItem] {
        guard let raw = rawData else {
            return []
        }
        return raw.arrayValue.map {
            GoodsItem(
                cover: $0["cover_image"].string,
                title: $0["name"].string,
                salePrice: $0["price"]["non_plus_user"]["sale_price"].float,
                discount: $0["price"]["non_plus_user"]["discount"].int,
                originPrice: $0["price"]["non_plus_user"]["origin_price"].float,
                plusPrice: $0["price"]["plus_user"]["sale_price"].float,
                plusDiscount: $0["price"]["plus_user"]["discount"].int
            )
        }
    }
    
    func changeType(_ type: String) {
        self.list = []
        self.page = 1
        self.lastPage = []
        self.isLoding = false
        self.type = type
        
        self.loadData()
    }
    
    func loadNewPage (_ list: [GoodsItem]) {
        guard list.count > 0 else {
            return
        }
        self.lastPage = list
        self.list += list
        self.page += 1
    }
    
    func loadData() {
        if isLoding { return }
        if !hasMore { return }
        isLoding = true
        API(.getPromotionList, ["type": type, "page": page]) { rawData in
            let list = self.parseRaw(rawData)
            self.loadNewPage(list)
            self.isLoding = false
        }
    }
}

