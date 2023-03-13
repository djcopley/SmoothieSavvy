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
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            AddRecipeView()
                .tabItem {
                    Label("Test", systemImage: "hammer")
                }
        }
    }
}

struct TestView: View {
    @State private var testData = ["item 1", "item 2", "item 3"]
    var body: some View {
        NavigationStack {
            Form {
                Section("Test") {
                    ForEach(0..<testData.count, id: \.self) {
                        Text(testData[$0])
                    }
                    .onMove {
                        testData.move(fromOffsets: $0, toOffset: $1)
                    }
                }
                
                Section("Test 2") {
                    ForEach(testData, id: \.self) {
                        Text($0)
                    }
                    .onMove {
                        testData.move(fromOffsets: $0, toOffset: $1)
                    }
                }
            }
            .toolbar {
                Button("Add") {
                    withAnimation {
                        testData.append("item \(testData.count)")
                    }
                }
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
