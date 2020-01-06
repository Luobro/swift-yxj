//
//  GoodsRowView.swift
//  yxj
//
//  Created by 罗彦鹏 on 2020/1/4.
//  Copyright © 2020 罗彦鹏. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct GoodsRowView: View {
    let data: GoodsItem
    var body: some View {
        HStack(spacing: 16.0){
            WebImage(url: URL(string: data.cover ?? ""))
                .resizable() // Resizable like SwiftUI.Image
                .placeholder(Image(systemName: "photo")) // Placeholder Image
                .animated() // Supports Animated Image
                .indicator(.activity) // Activity Indicator
                .animation(.easeInOut(duration: 0.5)) // Animation Duration
                .transition(.fade) // Fade Transition
                .scaledToFit()
                .frame(width: 100.0, height: 100.0)
                .cornerRadius(18.0)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading) {
                Text(data.title ?? "未知名称")
                HStack {
                    Text("HK$\(String(format: "%.2f", data.salePrice!))")
                        .foregroundColor(.red)
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                    if data.discount! > 0  {
                        Text("HK$\(String(format: "%.2f", data.originPrice!))")
                            .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.gray)
                            .strikethrough()
                    }
                }
                if data.plusPrice ?? 0 < data.salePrice ?? 0 {
                    HStack {
                        Text("HK$\(String(format: "%.2f", data.plusPrice!))")
                            .foregroundColor(.yellow)
                            .font(.subheadline)
//                            .shadow(radius: 10)
                    }
                }
            }
            .frame(height: 100.0, alignment: .top)
            Spacer()
        }
        .padding(16.0)
    }
}

struct GoodsRowView_Previews: PreviewProvider {
    static var previews: some View {
        GoodsRowView(
            data: GoodsItem(
                cover:"https://store.playstation.com/store/api/chihiro/00_09_000/container/CN/zh/999/HP0102-CUSA11510_00-SF5FULLGAME00000/1576816684000/image?w=480&h=480&bg_color=000000&opacity=100&_version=00_09_000",
                title: "街霸V (中文版)",
                salePrice: 74.0,
                discount: 50,
                originPrice: 148.0,
                plusPrice: 70.0,
                plusDiscount: 50
            )
        )
    }
}
