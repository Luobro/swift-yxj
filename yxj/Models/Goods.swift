//
//  GoodsItem.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/4.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//
import Combine
import SwiftUI

class GoodsItem {
    var cover: String?
    var title: String?
    init(cover: String?, title: String?) {
        self.cover = cover
        self.title = title
    }
}

class GoodsList: ObservableObject {
    @Published var list:[GoodsItem] = []
    var hasMore: Bool = true
    var page: Int = 1
    var type: String? = "latest"
    var isLoding: Bool = false
    
    init(type: String = "latest") {
        self.type = type
        loadData()
    }
    func loadData() {
        if isLoding { return }
        isLoding = true
        if !hasMore {
            isLoding = false
            return
        }
        API(.getPromotionList, ["type": type ?? "latest", "page": page]) { data in
            let rawList = data.arrayValue
            let list: [GoodsItem] = rawList.map { rawData in
                let cover = rawData["cover_image"].string
                let title = rawData["name"].string
                return GoodsItem(cover: cover, title: title)
            }
            
            if list.count < 20 {
                self.hasMore = false
            }
            
            if self.page == 1 {
                self.list = list
                self.page += 1
                self.isLoding = false
                return
            }
            
            self.list += list
            self.page += 1
            self.isLoding = false
        }
    }
}

