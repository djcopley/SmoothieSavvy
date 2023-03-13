//
//  FavoritesView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var recipeManager: RecipeManager
    @State private var searchText = ""
    
    var favoriteRecipes: [SmoothieRecipe] {
        let favorites = recipeManager.favoriteRecipes
        guard !searchText.isEmpty else {
            return favorites
        }
        return favorites.filter { recipe in
            recipe.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ListWithBackground(recipeManager.favoriteRecipes, defaultView: noFavoriteRecipes) { recipe in
                NavigationLink(recipe.name, value: recipe)
            }
            .searchable(text: $searchText)
            .background(BackgroundView())
            .navigationTitle("Favorites")
            .navigationDestination(for: SmoothieRecipe.self) { recipe in
                SmoothieRecipeView(recipe: recipe)
            }
        }
    }
    
    // MARK: Computed views
    @ViewBuilder
    var noFavoriteRecipes: some View {
        VStack(spacing: 8) {
            Text("No Favorites Yet")
                .font(.largeTitle)
            Text("Head back over to your favorite smoothie recipes and use the ❤️ button to save them here.")
                .foregroundColor(.secondary)
        }
        .padding()
        .font(.callout)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(RecipeManager())
    }
}
