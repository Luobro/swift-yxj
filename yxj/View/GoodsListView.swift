//
//  GoodsListView.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/4.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//

import SwiftUI
import Combine

class Observable<T>: ObservableObject, Identifiable {
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<T, Never>()
    var value: T {
        willSet { objectWillChange.send() }
        didSet { publisher.send(value) }
    }
    
    init(_ initValue: T) { self.value = initValue }
}

typealias ObservableInt = Observable<Int>

struct GoodsListView: View {
    
//    @State var listData: GoodsList = []
    @ObservedObject var goodsList = GoodsList()
    @State private var selectorIndex = ObservableInt(0)
    @State private var tabs = [("最新优惠", "latest"),("热门游戏", "hot"),("会员独享", "plus")]
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {
        
        NavigationView {
            List {
                ForEach(goodsList.list, id: \.title) { item in
                    GoodsRowView(data:item)
                }
                Text("没有更多了") // 触底加载更多数据
                    .onAppear {
                        self.goodsList.loadData()
                    }
            }
            .navigationBarItems(leading:
                Picker("Numbers", selection: $selectorIndex.value) {
                    ForEach(0 ..< tabs.count) { index in
                        Text(self.tabs[index].0).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onReceive(selectorIndex.publisher){
                    self.goodsList.changeType(self.tabs[$0].1)
                }
            )
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct GoodsListView_Previews: PreviewProvider {
    static var previews: some View {
        GoodsListView()
    }
}
