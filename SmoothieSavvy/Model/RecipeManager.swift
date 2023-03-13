//
//  SmoothieManager.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import SwiftUI

@MainActor
class RecipeManager: ObservableObject {
    @Published var favorites: Set<SmoothieRecipe.ID> = []
    
    init() {
        load()
    }
        
    // MARK: Favorites
    var favoriteRecipes: [SmoothieRecipe] {
        SmoothieRecipe.recipes.filter { recipe in
            favorites.contains(recipe.id)
        }
    }
    
    func isFavorite(recipe: SmoothieRecipe) -> Bool {
        return favorites.contains(recipe.id)
    }
    
    func toggleFavorite(recipe: SmoothieRecipe) {
        if !favorites.contains(recipe.id) {
            favorites.update(with: recipe.id)
        } else {
            favorites.remove(recipe.id)
        }
        save()
    }
    
    func recipesRelated(to recipe: SmoothieRecipe) -> [SmoothieRecipe] {
        SmoothieRecipe.recipes
    }
        
    func filteredRecipes(_ searchText: String) -> [SmoothieRecipe] {
        guard !searchText.isEmpty else {
            return SmoothieRecipe.recipes
        }
        return SmoothieRecipe.recipes.filter { recipe in
            recipe.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: Persist favorites
    private static func getFavoritesFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SmoothieRecipe.recipes.favorites")
    }
    
    func load() {
        do {
            let fileURL = try Self.getFavoritesFileURL()
            let data = try Data(contentsOf: fileURL)
            favorites = try JSONDecoder().decode(Set<SmoothieRecipe.ID>.self, from: data)
            print("Favorite recipes loaded: \(favorites.count)")
        } catch {
            print("Failed to load favorite recipes from file.")
        }
    }
    
    func save() {
        do {
            let fileURL = try Self.getFavoritesFileURL()
            let data = try JSONEncoder().encode(favorites)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("Favorite recipes saved")
        } catch {
            print("Unable to save")
        }
    }
}
