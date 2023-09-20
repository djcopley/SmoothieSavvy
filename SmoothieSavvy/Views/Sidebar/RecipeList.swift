//
//  RecipeList.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI
import SwiftData

struct RecipeList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var recipes: [Recipe]
    
    @State private var favoritesExpanded = true
    @State private var nonFavoritesExpanded = true
    @Binding var selectedRecipe: Recipe?
    
    init(searchText: String, selectedRecipe: Binding<Recipe?>) {
        _recipes = Query(filter: Recipe.predicate(searchText: searchText), sort: [.init(\Recipe.dateCreated)], animation: .bouncy)
        _selectedRecipe = selectedRecipe
    }
    
    var body: some View {
        List(selection: $selectedRecipe) {
            ForEach(recipes) { recipe in
                NavigationLink(value: recipe) { RecipeRow(recipe: recipe) }
            }
            .onDelete(perform: removeRecipes(at:))
        }
        .scrollContentBackground(.hidden)
        .background(LinearGradientBackground())
    }
    
    private func removeRecipes(at indices: IndexSet) {
        for index in indices {
            let recipeToDelete = recipes[index]
            modelContext.delete(recipeToDelete)
        }
    }
}

#Preview {
    RecipeList(searchText: "", selectedRecipe: .constant(nil))
        .modelContainer(PreviewSampleData.container)
}
