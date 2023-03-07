//
//  FavoritesView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct Favorites: View {
    @EnvironmentObject var recipeManager: RecipeManager
    
    var body: some View {
        NavigationStack {
            Group {
                if recipeManager.favoriteRecipes.isEmpty {
                    VStack(spacing: 8) {
                        Text("No Favorites Yet")
                            .font(.largeTitle)
                        
                        Text("Head back over to your favorite smoothie recipes and use the ❤️ button to save them here.")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .font(.callout)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(recipeManager.favoriteRecipes) { recipe in
                        Text(recipe.name)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Background())
            .navigationTitle("Favorites")
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
            .environmentObject(RecipeManager())
    }
}
