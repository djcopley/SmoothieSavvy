//
//  TestView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/27/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var ingredientFilterSheetIsPresented = false
    @State private var newRecipeSheetIsPresented = false
    
    @State private var searchText = ""
    @State private var selectedRecipe: Recipe?
    
    @State private var selectedFilterIngredients: Set<Ingredient> = []
    
    var body: some View {
        NavigationSplitView {
            RecipeList(searchText: searchText, selectedRecipe: $selectedRecipe)
                .searchable(text: $searchText)
                .toolbar { toolbarContent }
                .navigationTitle("SmoothieSavvy")
        } detail: {
            if let selectedRecipe {
                RecipeView(recipe: selectedRecipe)
            } else {
                ContentUnavailableView("No Recipe Selected", systemImage: "sidebar.left")
                    .background(LinearGradientBackground())
            }
        }
        .sheet(isPresented: $ingredientFilterSheetIsPresented) { FilterIngredientsSheet(selectedIngredients: $selectedFilterIngredients) }
        .sheet(isPresented: $newRecipeSheetIsPresented) { RecipeEditor() }
    }

}

extension ContentView {
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            IngredientFilterButton(ingredientFilterIsPresented: $ingredientFilterSheetIsPresented)
            Button {
                newRecipeSheetIsPresented = true
            } label: {
                Label("New Recipe", systemImage: "plus")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewSampleData.container)
}
