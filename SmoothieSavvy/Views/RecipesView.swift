//
//  RecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var recipeManager: RecipeManager
    
    @State private var ingredientPickerIsPreseneted = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(filteredRecipes) { recipe in
                NavigationLink(recipe.name, value: recipe)
            }
            .scrollContentBackground(.hidden)
            .background(BackgroundView())
            .searchable(text: $searchText, placement: .toolbar)
            .navigationTitle("Recipes")
            .navigationDestination(for: SmoothieRecipe.self) { recipe in
                SmoothieRecipeView(recipe: recipe)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        ingredientPickerIsPreseneted = true
                    } label: {
                        Label("Filter", systemImage: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $ingredientPickerIsPreseneted) {
                
            }
        }
    }
    
    // MARK: Computed Properties
    var filteredRecipes: [SmoothieRecipe] {
        recipeManager.recipes.filter { recipe in
            recipe.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // MARK: Computed Views
    @ViewBuilder
    func recipeRow(for recipe: SmoothieRecipe) -> some View {
        HStack {
            Text(recipe.name)
            Spacer()
            if recipeManager.favorites.contains(recipe.id) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .onTapGesture {
                        recipeManager.favorites.remove(recipe.id)
                    }
            }
        }
    }
}

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
            .environmentObject(RecipeManager())
    }
}
