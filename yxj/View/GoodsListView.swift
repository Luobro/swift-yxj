//
//  GoodsListView.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/4.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//

import SwiftUI

struct GoodsListView: View {
    
    @State var listData: GoodsList = []
    var body: some View {
        List {
            ForEach(listData, id: \.self) { item in
                GoodsRowView(data:item)
            }
        }.onAppear {
            API(host:"https://api-plus.lhbgame.com/").fetch(MyRequest(paramenters: nil)) {resource in
                let rawList = resource.data!.arrayValue
                let list: GoodsList = rawList.map { rawData in
                    let cover = rawData["cover_image"].string
                    let title = rawData["name"].string
                    return GoodsItem(cover: cover, title: title)
                }
                self.listData = list
            }
        }
    }
}

struct GoodsListView_Previews: PreviewProvider {
    static var previews: some View {
        GoodsListView()
    }
}
