//
//  FavoritesView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var searchText = ""
    
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "isFavorite == %@", "YES"),
        animation: .default
    ) var favorites: FetchedResults<Recipe>
    
    var body: some View {
        NavigationStack {
            DefaultStack(when: favorites.isEmpty, show: noFavoriteRecipes) {
                List {
                    ForEach(favorites) { recipe in
                        NavigationLink(recipe.name, value: recipe)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .searchable(text: $searchText)
            .background(GradientBackground())
            .navigationTitle("Favorites")
            .navigationDestination(for: Recipe.self) { recipe in
                SmoothieRecipeView(recipe: recipe)
            }
        }
    }
    
    // MARK: Computed views
    @ViewBuilder
    private func noFavoriteRecipes() -> some View {
        VStack(spacing: 8) {
            if favorites.isEmpty {
                Text("No Favorites Yet")
                    .font(.largeTitle)
                Text("Head back over to your favorite smoothie recipes and use the ❤️ button to save them here.")
                    .foregroundColor(.secondary)
            } else {
                Text("No Recipes Found")
                    .font(.largeTitle)
                Text("Try a different search and try again.")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .font(.callout)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
