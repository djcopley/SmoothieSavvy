//
//  RecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var recipeData: SmoothieRecipeData
    
    @State private var addRecipeViewIsPresented = false
    @State private var ingredientPickerIsPreseneted = false
    @State private var selectedIngredients: Set<Ingredient.ID> = []
    @State private var searchText = ""
    
//    private var filteredRecipes: [SmoothieRecipe] {
//        let searchedRecipes = recipeData.filteredRecipes(searchText)
//        guard !selectedIngredients.isEmpty else {
//            return searchedRecipes
//        }
//        return searchedRecipes.filter { recipe in
//            let ingredientIds = recipe.ingredients.map { $0.id }
//            return selectedIngredients.isStrictSubset(of: ingredientIds)
//        }
//    }
    
    var body: some View {
        NavigationStack {
            ListWithBackground(recipeData.recipes, defaultView: noMatchingRecipes) { recipe in
                NavigationLink(recipe.name, value: recipe)
            }
            .background(BackgroundView())
            .searchable(text: $searchText, placement: .toolbar)
            .navigationTitle("Recipes")
            .navigationDestination(for: SmoothieRecipe.self) { recipe in
                SmoothieRecipeView(recipe: recipeData.getBinding(for: recipe)!)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        ingredientPickerIsPreseneted = true
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addRecipeViewIsPresented = true
                    } label: {
                        Label("Add Recipe", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $ingredientPickerIsPreseneted) {
                IngredientsView(selectedIngredients: $selectedIngredients)
            }
            .sheet(isPresented: $addRecipeViewIsPresented) {
                AddRecipeView()
            }
        }
    }

    
    // MARK: Computed Views
    @ViewBuilder
    func recipeRow(for recipe: SmoothieRecipe) -> some View {
        HStack {
            Text(recipe.name)
            Spacer()
            if recipe.isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }

    @ViewBuilder
    var noMatchingRecipes: some View {
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
            .environmentObject(SmoothieRecipeData())
    }
}
