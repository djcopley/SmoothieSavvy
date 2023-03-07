//
//  TestView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Recipes()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            Favorites()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeManager())
    }
}
