//
//  SmoothieRecipeData.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import SwiftUI

@MainActor
class SmoothieRecipeData: ObservableObject {
    @Published var recipes: [SmoothieRecipe] = [
        .bananaBreakfastShake,
        .breakfastBar,
        .riseAndShine,
        .breakfastSmoothie,
        .wakeUpSweetie
    ]
    
    var favorites: [SmoothieRecipe] {
        recipes.filter { $0.isFavorite }
    }
    
    func add(recipe: SmoothieRecipe) {
        recipes.append(recipe)
    }
    
    func remove(recipe: SmoothieRecipe) {
        recipes.removeAll { $0.id == recipe.id }
    }
    
    /// Recommends a list of smoothie recipes that are similar
    /// - Parameter recipe: recipe from which to generate recommendations
    /// - Returns: similar smoothie recommendations
    func recipesRelated(to recipe: SmoothieRecipe) -> [SmoothieRecipe] {
        recipes
    }
    
    func getBinding(for recipe: SmoothieRecipe) -> Binding<SmoothieRecipe>? {
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else {
            return nil
        }
        return Binding(
            get: {
                self.recipes[index]
            }, set: { updatedRecipe in
                self.recipes[index] = updatedRecipe
            }
        )
    }
    
    // MARK: Persist recipes
    private func getRecipesFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appending(component: "recipes.data")
    }
    
    private func getRecipesImageURL(for imageName: String) throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appending(components: "images", imageName, directoryHint: .notDirectory)
    }
    
    func load() {
        do {
            let fileURL = try getRecipesFileURL()
            let data = try Data(contentsOf: fileURL)
            recipes = try JSONDecoder().decode([SmoothieRecipe].self, from: data)
            print("Favorite recipes loaded: \(favorites.count)")
        } catch {
            print("Failed to load favorite recipes from file. Using backup.")
        }
    }
    
    func save() {
        do {
            let fileURL = try getRecipesFileURL()
            let data = try JSONEncoder().encode(recipes)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("Smoothie recipes saved.")
        } catch {
            print("Unable to save smoothie recipes.")
        }
    }
    
    func saveImage() {
        
    }
}