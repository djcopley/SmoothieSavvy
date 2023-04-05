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
    
    // The state passed to this view (viewModel and recipe) are causing a weird graphical hiccup when the popover is presented
    
    @Environment(\.dismiss) var dismiss
    @FocusState var focusedIngredient: Ingredient?
    @FocusState var focusedDirection: Int?
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name_)],
        animation: .default
    ) var ingredients: FetchedResults<Ingredient>
    
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
                        viewModel.imageState = .success(recipeImage)
                        return true
                    } isTargeted: { _ in }
                }

                Section("Details") {
                    TextField("Name", text: $viewModel.recipe.name)
                    TextField("Description", text: $viewModel.recipe.info.with(default: ""))
                }

//                Section("Ingredients") {
//                    ForEach(viewModel.recipe.sortedIngredients) { ingredient in
//                        TextField("New Ingredient", text: .constant(ingredient.name))
//                            .focused($focusedIngredient, equals: ingredient)
//                    }
//
//                    Button { // TODO: there is a lot of stuff in this module
//                        viewModel.recipe.addToIngredients(Ingredient(name: "Lol", emoji: "😀", context: moc))
//                    } label: {
//                        Label("Add Ingredient", systemImage: "plus")
//                    }
//                }
//
//                Section("Directions") {
//                    ForEach($viewModel.recipe.directions.enumeratedArray(), id: \.offset) { (index, $direction) in
//                        TextField("New Step", text: $direction)
//                            .focused($focusedDirection, equals: index)
//                    }
//
//                    Button {
//                        let newDirection = "New Direction"
//                        viewModel.recipe.directions.append(newDirection)
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
            .background(LinearGradientBackground())
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
