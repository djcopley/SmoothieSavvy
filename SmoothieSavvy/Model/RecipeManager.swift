//
//  SmoothieManager.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import SwiftUI

class RecipeManager: ObservableObject {
    @Published var recipes: [SmoothieRecipe] = [
        .bananaBreakfastShake,
        .breakfastBar,
        .riseAndShine,
        .breakfastSmoothie,
        .wakeUpSweetie,
    ]
    
    @Published var favorites: Set<SmoothieRecipe.ID> = [
        SmoothieRecipe.bananaBreakfastShake.id
    ]
    
    func isFavorite(recipe: SmoothieRecipe) -> Bool {
        return favorites.contains(recipe.id)
    }
    
    func toggleFavorite(recipe: SmoothieRecipe) {
        guard let _ = favorites.remove(recipe.id) else {
            favorites.update(with: recipe.id)
            return
        }
    }
    
    var favoriteRecipes: [SmoothieRecipe] {
        recipes.filter { recipe in
            favorites.contains(recipe.id)
        }
    }
    
    func recipesRelated(to recipe: SmoothieRecipe) -> [SmoothieRecipe]{
        recipes
    }
    
    // MARK: Persist favorites
    private static func getFavoritesFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("recipes.favorites")
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
    
    // MARK: No longer used
//    func getBinding(to recipe: SmoothieRecipe) -> Binding<SmoothieRecipe> {
//        guard let index = self.recipes.firstIndex(where: { $0.id == recipe.id }) else {
//            fatalError("Binding requested for non existent recipe.")
//        }
//
//        return Binding(
//            get: {
//                return self.recipes[index]
//            },
//            set: { recipe in
//                self.recipes[index] = recipe
//            }
//        )
//    }
//
//    func filteredRecipes(_ searchText: String) -> Binding<[SmoothieRecipe]> {
//        Binding<[SmoothieRecipe]>(
//            get: {
//                guard !searchText.isEmpty else { return self.recipes }
//                return self.recipes.filter { recipe in
//                    recipe.name.localizedCaseInsensitiveContains(searchText)
//                }
//            },
//            set: { recipes in
//                for recipe in recipes {
//                    if let index = self.recipes.firstIndex(where: { $0.id == recipe.id }) {
//                        self.recipes[index] = recipe
//                    }
//                }
//            }
//        )
//    }
}
