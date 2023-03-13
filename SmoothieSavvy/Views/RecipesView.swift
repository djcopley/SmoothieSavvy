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
    @State private var selectedIngredients: Set<Ingredient.ID> = []
    @State private var searchText = ""
    
    private var filteredRecipes: [SmoothieRecipe] {
        let searchedRecipes = recipeManager.filteredRecipes(searchText)
        guard !selectedIngredients.isEmpty else {
            return searchedRecipes
        }
        return searchedRecipes.filter { recipe in
            let ingredientIds = recipe.ingredients.map { $0.id }
            return selectedIngredients.isStrictSubset(of: ingredientIds)
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if filteredRecipes.isEmpty {
                    noMatchingRecipes()
                } else {
                    List(filteredRecipes) { recipe in
                        NavigationLink(recipe.name, value: recipe)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
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
                IngredientsView(selectedIngredients: $selectedIngredients)
            }
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

    @ViewBuilder
    func noMatchingRecipes() -> some View {
        VStack(spacing: 8) {
            Text("No Recipes Found")
                .font(.largeTitle)
            Text("Try a different search and try again.")
                .foregroundColor(.secondary)
            
            Button("Clear Search") {
                searchText = ""
                selectedIngredients = []
            }
            .padding(.vertical, 10)
        }
        .padding()
        .font(.callout)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
            .environmentObject(RecipeManager())
    }
}
