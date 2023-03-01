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
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "binoculars")
                }
            
            Text("Recipes")
                .tabItem {
                    Label("Recipes", systemImage: "books.vertical")
                }
            
            Text("Favorites")
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
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
