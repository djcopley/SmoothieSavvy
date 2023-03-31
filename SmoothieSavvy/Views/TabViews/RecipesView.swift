//
//  RecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var addRecipeViewIsPresented = false
    @State private var ingredientPickerIsPreseneted = false
    @State private var selectedIngredients: Set<Ingredient.ID> = []
    @State private var searchText = ""
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    ) private var recipes: FetchedResults<Recipe>

    
    var body: some View {
        NavigationStack {
            DefaultStack(when: recipes.isEmpty, show: noMatchingRecipes) {
                List {
                    ForEach(recipes) { recipe in
                        NavigationLink(value: recipe) {
                            recipeRow(for: recipe)
                        }
                    }
                    .onDelete(perform: deleteRecipes)
                }
                .scrollContentBackground(.hidden)
            }
            .background(GradientBackground())
            .searchable(text: $searchText, placement: .toolbar)
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
            .sheet(isPresented: $addRecipeViewIsPresented) {
                EditRecipeView(viewModel: .init(persistenceController: .preview))
            }
        }
    }
    
    // MARK: - Helpers
    private func deleteRecipes(at offsets: IndexSet) {
        withAnimation {
            offsets.map { recipes[$0] }.forEach(viewContext.delete)
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
        RecipesView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
