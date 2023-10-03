//
//  SmoothieSavvyApp.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct SmoothieSavvyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .onOpenURL { url in
//                    guard url.pathExtension == UTType.smoothieRecipe.preferredFilenameExtension else {
//                        print("File does not end with .smoothierecipe extension")
//                        return
//                    }
//
//                    guard let data = try? Data(contentsOf: url) else {
//                        print("Error reading data from file")
//                        return
//                    }
//
//                    guard let recipe = try? JSONDecoder().decode(SmoothieRecipe.self, from: data) else {
//                        print("Unable to decode recipe file")
//                        return
//                    }
//
//                    importedRecipe = recipe
//                    showingImportAlertIsPresented = true
//                }
//                .alert("Import Recipe", isPresented: $showingImportAlertIsPresented, presenting: importedRecipe) { recipe in
//                    Button("Import") { recipeData.add(recipe: recipe) }
//                    Button("Cancel", role: .cancel) { }
//                } message: { recipe in
//                    Text("Do you want to import the recipe:\n\(recipe.name)?")
//                }
        }
        .modelContainer(for: [Recipe.self, Ingredient.self])
    }
}
