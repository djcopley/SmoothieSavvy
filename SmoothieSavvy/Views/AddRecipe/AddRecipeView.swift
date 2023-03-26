//
//  AddRecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/13/23.
//

import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeData: SmoothieRecipeData

    @StateObject private var viewModel = AddRecipeViewModel()
    
    @FocusState var focusedIngredient: Ingredient?
    @FocusState var focusedDirection: Direction?

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
                    .dropDestination(for: RecipeImage.self) { recipeImages, location in
                        guard let recipeImage = recipeImages.first else {
                            viewModel.imageState = .failure(TransferError.importFailed)
                            return false
                        }
                        viewModel.imageState = .success(recipeImage.image)
                        return true
                    } isTargeted: { _ in }
                }
                
                Section("Details") {
                    TextField("Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Ingredients") {
                    ForEach($viewModel.ingredients) { $ingredient in
                        TextField("New Ingredient", text: $ingredient.name)
                            .focused($focusedIngredient, equals: ingredient)
                    }
                    .onDelete {
                        viewModel.ingredients.remove(atOffsets: $0)
                    }
                    .onMove {
                        viewModel.ingredients.move(fromOffsets: $0, toOffset: $1)
                    }

                    Button {
                        let newIngredient = Ingredient(name: "")
                        viewModel.ingredients.append(newIngredient)
                        focusedIngredient = newIngredient
                    } label: {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }

                Section("Directions") {
                    ForEach($viewModel.directions) { $direction in
                        TextField("New Step", text: $direction.text)
                            .focused($focusedDirection, equals: direction)
                    }
                    .onDelete {
                        viewModel.directions.remove(atOffsets: $0)
                    }
                    .onMove {
                        viewModel.directions.move(fromOffsets: $0, toOffset: $1)
                    }

                    Button {
                        let newStep = Direction(text: "")
                        viewModel.directions.append(newStep)
                        focusedDirection = newStep
                    } label: {
                        Label("Add Step", systemImage: "plus")
                    }
                }

                Section("Notes") {
                    TextEditor(text: $viewModel.notes)
                        .frame(height: 100)
                }
            }
            .scrollContentBackground(.hidden)
            .background(GradientBackground())
            .navigationTitle("Add Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let newRecipe = SmoothieRecipe(
                            name: viewModel.name,
                            description: viewModel.description,
                            directions: viewModel.directions.map { $0.text },
                            ingredients: viewModel.ingredients,
                            notes: viewModel.notes
                        )
                        recipeData.add(recipe: newRecipe)
                        dismiss()
                    }
                    .disabled(!recipeIsValid)
                }
            }
        }
    }
    
    var recipeIsValid: Bool {
        !viewModel.name.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
