//
//  ContentView.swift
//
//  Created by 罗彦鹏 on 2020/1/3.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            NavigationView { GoodsListView() }
                .tabItem {
                    VStack {
                        Image("first")
                        Text("正在促销")
                    }
                }
                .tag(0)
            Text("所有游戏")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("所有游戏")
                    }
                }
                .tag(1)
            Text("奖杯")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("奖杯")
                    }
                }
                .tag(2)
            Text("我的")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("我的")
                    }
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
