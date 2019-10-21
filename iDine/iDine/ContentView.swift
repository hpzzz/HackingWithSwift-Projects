//
//  ContentView.swift
//  iDine
//
//  Created by Karol Harasim on 28/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            ItemRow(item: item)
                        }
                    }
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Menu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
