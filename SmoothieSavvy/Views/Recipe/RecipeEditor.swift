//
//  RecipeEditor.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/18/23.
//

import SwiftUI
import PhotosUI

struct RecipeEditor: View {
    let recipe: Recipe?
    @StateObject private var viewModel: ImageViewModel
    
    init(recipe: Recipe? = nil) {
        self.recipe = recipe
        _viewModel = StateObject(wrappedValue: ImageViewModel(recipe: recipe!))
    }
    
    private var title: String {
        recipe == nil ? "Add Recipe" : "Edit Recipe"
    }
    
    @FocusState private var focusedIngredient
    @FocusState private var focusedDirection
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    
    @State private var name = ""
    @State private var info = ""
    @State private var notes = ""
    @State private var directions = [String]()
    @State private var ingredients = [Ingredient]()
    
    @State private var newDirection = ""
    @State private var newIngredient = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Picture") {
                    PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                        HStack {
                            Label("Smoothie Photo", systemImage: "photo.on.rectangle.angled")
                            Spacer()
                            RoundedRectangleRecipeImageView(imageState: viewModel.imageState)
                        }
                        .frame(height: 60)
                    }
                    .dropDestination(for: ImageViewModel.RecipeImage.self) { recipeImages, location in
                        guard let recipeImage = recipeImages.first else {
                            viewModel.imageState = .failure(ImageViewModel.TransferError.importFailed)
                            return false
                        }
                        viewModel.imageState = .success(recipeImage)
                        return true
                    } isTargeted: { _ in }
                }
                
                Section("Details") {
                    TextField("Name", text: $name)
                    TextField("Description", text: $info)
                }
                
                Section("Ingredients") {
                    ForEach(ingredients) { ingredient in
                        HStack {
                            Text(ingredient.emoji)
                            Text(ingredient.name)
                        }
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            ingredients.remove(atOffsets: indexSet)
                        }
                    }
                    
                    TextField("New Ingredient", text: $newIngredient)
                    
                    Button {
                        withAnimation {
                            ingredients.append(Ingredient(name: newIngredient, emoji: "🥲"))
                        }
                        newIngredient = ""
                    } label: {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }
                
                Section("Directions") {
                    ForEach(directions, id: \.self) { direction in
                        Text(direction)
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            directions.remove(atOffsets: indexSet)
                        }
                    }
                    
                    TextField("New Direction", text: $newDirection)
                    
                    Button {
                        withAnimation {
                            directions.append(newDirection)
                        }
                        newDirection = ""
                    } label: {
                        Label("Add Step", systemImage: "plus")
                    }
                }
                
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(LinearGradientBackground())
            .onAppear {
                if let recipe {
                    name = recipe.name
                    info = recipe.info
                    notes = recipe.notes
                    directions = recipe.directions
                    ingredients = recipe.ingredients
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func save() {
        if let recipe {
            recipe.name = name
            recipe.info = info
            recipe.notes = notes
            recipe.directions = directions
            recipe.ingredients = ingredients
        } else {
            let newRecipe = Recipe(name: name, directions: directions, info: info, notes: notes)
            newRecipe.ingredients = ingredients
            modelContext.insert(newRecipe)
        }
    }
}

#Preview {
    RecipeEditor()
}
