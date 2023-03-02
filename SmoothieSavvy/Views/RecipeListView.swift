//
//  RecipeListView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var recipeManager: RecipeManager
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(recipeManager.filteredRecipes(searchText)) { $recipe in
                HStack {
                    Text(recipe.name)
                    Spacer()
                    if recipe.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                recipe.isFavorite.toggle()
                            }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(BackgroundView())
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

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeManager())
    }
}
