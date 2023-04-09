//
//  EditRecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/13/23.
//

import SwiftUI
import PhotosUI
import EmojiPicker

struct EditRecipeView: View {
    @StateObject private var viewModel: EditRecipeViewModel

    init(recipe: Recipe? = nil) {
        _viewModel = StateObject(wrappedValue: .init(recipe: recipe))
    }
    
    @Environment(\.dismiss) var dismiss
    @FocusState var focusedIngredient: Ingredient?
    @FocusState var focusedDirection: Int?
    @Environment(\.managedObjectContext) var moc
    
    @State var emojiPickerIsPresented = false

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

                Section("Ingredients") {
                    ForEach(viewModel.recipe.sortedIngredients) { ingredient in
                        HStack {
                            TextField("New Ingredient", text: ingredient.nameBinding)
                                .focused($focusedIngredient, equals: ingredient)
                            EmojiView(emoji: ingredient.emojiBinding)
                                .onTapGesture {
                                    emojiPickerIsPresented = true
                                }
                                .sheet(isPresented: $emojiPickerIsPresented) {
                                    NavigationStack {
                                        EmojiPickerView(selectedEmoji: Binding(ingredient.emojiBinding), emojiProvider: IngredientEmojiProvider())
                                            .navigationTitle("Ingredient Emoji")
                                    }
                                }
                        }
                    }
                    .onDelete { offsets in
                        viewModel.deleteIngredient(from: offsets)
                    }

                    Button {
                        focusedIngredient = viewModel.newIngredient()
                    } label: {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }

                Section("Directions") {
                    ForEach($viewModel.recipe.directions.enumeratedArray(), id: \.offset) { (index, $direction) in
                        TextField("New Step", text: $direction)
                            .focused($focusedDirection, equals: index)
                    }
                    .onDelete { offsets in
                        viewModel.deleteDirection(from: offsets)
                    }
                    .onMove { offsets, offset in
                        viewModel.moveDirection(from: offsets, to: offset)
                    }

                    Button {
                        let _ = viewModel.newDirection()
                    } label: {
                        Label("Add Step", systemImage: "plus")
                    }
                }

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
                    .disabled(!viewModel.recipeIsValid)
                }
            }
        }
    }
}


struct EmojiView: View {
    @Binding var emoji: Emoji

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.primary.opacity(0.1))
            .overlay {
                Text(emoji.value)
                    .font(.title)
            }
            .frame(width: 45, height: 45)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static let moc = PersistenceController.preview.container.viewContext
    static let recipe = try! moc.fetch(Recipe.fetchRequest()).first!

    static var previews: some View {
        EditRecipeView()
    }
}
