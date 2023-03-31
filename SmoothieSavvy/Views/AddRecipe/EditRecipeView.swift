//
//  EditRecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/13/23.
//

import SwiftUI
import PhotosUI

struct EditRecipeView: View {
    @StateObject var viewModel: EditRecipeViewModel
    
    @Environment(\.dismiss) var dismiss
    @FocusState var focusedIngredient: Ingredient?
    @FocusState var focusedDirection: String.ID?

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
                    .dropDestination(for: EditRecipeViewModel.RecipeImage.self) { recipeImages, location in
                        guard let recipeImage = recipeImages.first else {
                            viewModel.imageState = .failure(EditRecipeViewModel.TransferError.importFailed)
                            return false
                        }
                        viewModel.imageState = .success(recipeImage.image)
                        return true
                    } isTargeted: { _ in }
                }
                
                Section("Details") {
                    TextField("Name", text: $viewModel.recipe.name)
                    TextField("Description", text: $viewModel.recipe.info.with(default: ""))
                }

                Section("Ingredients") {
                    ForEach($viewModel.ingredients) { $ingredient in
                        TextField("New Ingredient", text: $ingredient.name)
                            .focused($focusedIngredient, equals: ingredient)
                    }
                    .onDelete {
                        viewModel.ingredients.remove(atOffsets: $0)
                    }

                    Button { // TODO: there is a lot of stuff in this module
                        focusedIngredient = viewModel.newIngredient()
                    } label: {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }
//
//                Section("Directions") {
//                    ForEach($viewModel.directions) { $direction in
//                        TextField("New Step", text: $direction)
//                            .focused($focusedDirection, equals: direction.id)
//                    }
//                    .onDelete {
//                        viewModel.directions.remove(atOffsets: $0)
//                    }
//                    .onMove {
//                        viewModel.directions.move(fromOffsets: $0, toOffset: $1)
//                    }
//
//                    Button {
//                        let newStep = ""
//                        viewModel.directions.append(newStep)
//                        focusedDirection = newStep.id
//                    } label: {
//                        Label("Add Step", systemImage: "plus")
//                    }
//                }

                Section("Notes") {
                    TextEditor(text: $viewModel.recipe.notes.with(default: ""))
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
                    Button("Save") {
                        viewModel.persist()
                        dismiss()
                    }
                    .disabled(!recipeIsValid)
                }
            }
        }
    }
    
    var recipeIsValid: Bool {
        !viewModel.recipe.name.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

//struct AddRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRecipeView()
//    }
//}
