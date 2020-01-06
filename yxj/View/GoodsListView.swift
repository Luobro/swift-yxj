//
//  GoodsListView.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/4.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//

import SwiftUI

struct GoodsListView: View {
    
//    @State var listData: GoodsList = []
    @ObservedObject var goodsList = GoodsList()
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {
        NavigationView {
            List() {
                ForEach(goodsList.list, id: \.title) { item in
                    GoodsRowView(data:item)
                }
                Text("。。。") // 触底加载更多数据
                    .onAppear {
                        self.goodsList.loadData()
                    }
            }
            .navigationBarTitle(Text("正在促销"))
        }
    }
}

struct GoodsListView_Previews: PreviewProvider {
    static var previews: some View {
        GoodsListView()
    }
}
