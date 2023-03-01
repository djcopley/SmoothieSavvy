//
//  SmoothieSavvyApp.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI

@main
struct SmoothieSavvyApp: App {
    @StateObject var smoothieManager = RecipeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(smoothieManager)
        }
    }
}
