//
//  RecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct RecipesSidebarView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var addRecipeViewIsPresented = false
    @State private var ingredientPickerIsPreseneted = false
    @State private var selectedIngredients: Set<Ingredient.ID> = []
    @State private var searchText = ""

    private var query: Binding<String> {
        Binding {
            searchText
        } set: { queryText in
            searchText = queryText
            nonFavoriteRecipes.nsPredicate = queryText.isEmpty ? nil : NSPredicate(format: "name_ BEGINSWITH[c] %@", queryText)
        }
    }
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name_)],
        predicate: NSPredicate(format: "isFavorite == YES"),
        animation: .default
    ) private var favoriteRecipes: FetchedResults<Recipe>
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name_)],
        predicate: NSPredicate(format: "isFavorite == NO"),
        animation: .default
    ) private var nonFavoriteRecipes: FetchedResults<Recipe>

    
    var body: some View {
        List {
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
        .navigationDestination(for: Recipe.self) { recipe in
            SmoothieRecipeView(recipe: recipe)
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
}

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        RecipesSidebarView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
