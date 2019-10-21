//
//  ItemDetail.swift
//  iDine
//
//  Created by Karol Harasim on 28/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order: Order
    var item: MenuItem
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing ) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            Text(item.description)
            .padding()
            
            Button("Order This") {
                self.order.add(item: self.item)
            }.font(.headline)
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
//                .frame(maxWidth: .infinity)
                .background(Color.blue)
            .layoutPriority(1)
                .foregroundColor(Color.white)
                .cornerRadius(.infinity)
            
            Spacer()
            
        }.navigationBarTitle(Text(item.name), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {}) {
                Text("Favorite")
            })
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example).environmentObject(order)
        }
    }
}
