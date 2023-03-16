//
//  SmoothieSavvyApp.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI

@main
struct SmoothieSavvyApp: App {
    @StateObject var recipeData = SmoothieRecipeData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipeData)
                .task {
                    recipeData.load()
                }
                .onChange(of: recipeData.recipes) { _ in
                    recipeData.save()
                }
        }
    }
}
