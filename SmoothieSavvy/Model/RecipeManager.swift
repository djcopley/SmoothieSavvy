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
        .riseAndShine
    ]
    
    func filteredRecipes(_ searchText: String) -> Binding<[SmoothieRecipe]> {
        Binding<[SmoothieRecipe]>(
            get: {
                guard !searchText.isEmpty else { return self.recipes }
                return self.recipes.filter { recipe in
                    recipe.name.localizedCaseInsensitiveContains(searchText)
                }
            },
            set: { recipes in
                for recipe in recipes {
                    if let index = self.recipes.firstIndex(where: { $0.id == recipe.id }) {
                        self.recipes[index] = recipe
                    }
                }
            }
        )
    }
}
