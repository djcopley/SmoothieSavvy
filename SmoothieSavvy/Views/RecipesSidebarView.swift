//
//  RecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct RecipesSidebarView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var selectedRecipe: Recipe?
    
    @State private var addRecipeViewIsPresented = false
    @State private var ingredientPickerIsPreseneted = false
    @State private var selectedIngredients: Set<Ingredient.ID> = []

    @State private var searchText = ""
    private var query: Binding<String> {
        Binding {
            searchText
        } set: { queryText in
            searchText = queryText
            
            guard !queryText.isEmpty else {
                favoriteRecipes.nsPredicate = Self.isFavoritePredicate
                nonFavoriteRecipes.nsPredicate = Self.isNotFavoritePredicate
                return
            }
    
            let searchPredicate = NSPredicate(format: "name_ BEGINSWITH[c] %@", queryText)
            favoriteRecipes.nsPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [Self.isFavoritePredicate, searchPredicate])
            nonFavoriteRecipes.nsPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [Self.isNotFavoritePredicate, searchPredicate])
        }
    }
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name_)],
        predicate: isFavoritePredicate,
        animation: .default
    ) private var favoriteRecipes: FetchedResults<Recipe>
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name_)],
        predicate: isNotFavoritePredicate,
        animation: .default
    ) private var nonFavoriteRecipes: FetchedResults<Recipe>

    var body: some View {
        List(selection: $selectedRecipe) {
            Section("Favorites") {
                ForEach(favoriteRecipes) { recipe in
                    NavigationLink(value: recipe) {
                        recipeRow(for: recipe)
                    }
                }
                .onDelete(perform: deleteFavorites)
            }
            
            Section("Recipes") {
                ForEach(nonFavoriteRecipes) { recipe in
                    NavigationLink(value: recipe) {
                        recipeRow(for: recipe)
                    }
                }
                .onDelete(perform: deleteNonFavorites)
            }
        }
        .scrollContentBackground(.hidden)
        .background(LinearGradientBackground())
        .searchable(text: query, placement: .toolbar)
        .navigationTitle("Recipes")
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
            SelectIngredientsView(selectedIngredients: $selectedIngredients)
        }
//        .sheet(isPresented: $addRecipeViewIsPresented) {
//            EditRecipeView(recipe: Recipe(name: "New Recipe", context: viewContext))
//        }
    }
    
    // MARK: - Helpers
    private func deleteFavorites(at offsets: IndexSet) {
        withAnimation {
            offsets.map { favoriteRecipes[$0] }.forEach(viewContext.delete)
        }
        PersistenceController.shared.save()
    }
    
    private func deleteNonFavorites(at offsets: IndexSet) {
        withAnimation {
            offsets.map { nonFavoriteRecipes[$0] }.forEach(viewContext.delete)
        }
        PersistenceController.shared.save()
    }
    
    // MARK: - Computed Views
    @ViewBuilder
    private func recipeRow(for recipe: Recipe) -> some View {
        HStack {
            Text(recipe.name)
            Spacer()
            Image(systemName: "heart.fill")
                .font(.subheadline)
                .foregroundColor(.red)
                .opacity(recipe.isFavorite ? 1 : 0)
        }
    }

    @ViewBuilder
    private func noMatchingRecipes() -> some View {
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
    
    private static let isFavoritePredicate = NSPredicate(format: "isFavorite == YES")
    private static let isNotFavoritePredicate = NSPredicate(format: "isFavorite == NO")

}

//struct Recipes_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipesSidebarView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}