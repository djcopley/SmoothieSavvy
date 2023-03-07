//
//  RecipeListView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct Recipes: View {
    @EnvironmentObject var recipeManager: RecipeManager
    
    @State private var searchText = ""
    
    // todo: remove this, it is just a placeholder
    @State private var isFavorite = true
    
    var body: some View {
        NavigationStack {
            List(recipeManager.filteredRecipes(searchText)) { $recipe in
                HStack {
                    Text(recipe.name)
                    Spacer()
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                isFavorite.toggle()
                            }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Background())
            .searchable(text: $searchText, placement: .toolbar)
            .navigationTitle("Recipes")
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    var listRowBackgroundColor: Color {
        switch colorScheme {
        case .light:
            return .mint
        default:
            return .secondary
        }
    }
}

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        Recipes()
            .environmentObject(RecipeManager())
    }
}
