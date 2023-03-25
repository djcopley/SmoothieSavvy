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
    
    private var filteredRecipes: [SmoothieRecipe] {
        let searchedRecipes = recipeData.recipes.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
        }
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
            DefaultView(when: filteredRecipes.isEmpty, show: noMatchingRecipes) {
                List {
                    ForEach(filteredRecipes) { recipe in
                        NavigationLink(value: recipe) {
                            HStack {
                                Text(recipe.name)
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                                    .opacity(recipe.isFavorite ? 1 : 0)
                            }
                        }
                    }
                    .onDelete { indices in
                        for index in indices {
                            recipeData.remove(recipe: filteredRecipes[index])
                        }
                    }
                }
                .scrollContentBackground(.hidden)
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
            .environmentObject(SmoothieRecipeData())
    }
}
