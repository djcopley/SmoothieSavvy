//
//  AddRecipeView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/13/23.
//

import SwiftUI
import PhotosUI
import Camera_SwiftUI

struct AddRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recipeData: SmoothieRecipeData

    @State private var name = ""
    @State private var description = ""

    @State private var ingredients: [Ingredient] = []
    @State private var newIngredientIsPresented = false
    @State private var newIngredientName = ""
    @FocusState private var focusedIngredient: Ingredient?

    @State private var directions: [String] = []
    @State private var newStepIsPresented = false
    @State private var newStep = ""
    @FocusState private var focusedDirections: String?

    @State private var notes = ""
    @State private var cameraIsPresented = false
    
    @State private var isTargeted = false
    
    var session = AVCaptureSession()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }

                Section("Ingredients") {
                    ForEach($ingredients, id: \.self) { $ingredient in
                        TextField("New Ingredient", text: $ingredient.name)
                    }
                    .onDelete {
                        ingredients.remove(atOffsets: $0)
                    }
                    .onMove {
                        ingredients.move(fromOffsets: $0, toOffset: $1)
                    }

                    if newIngredientIsPresented {
                        TextField("New Ingredient", text: $newIngredientName)
                            .onSubmit {
                                if !newIngredientName.trimmingCharacters(in: .whitespaces).isEmpty {
                                    ingredients.append(Ingredient(name: newIngredientName))
                                }
                                newIngredientName = ""
                                newIngredientIsPresented = false
                            }
                    }

                    Button {
                        newIngredientIsPresented = true
                    } label: {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }

                Section("Directions") {
                    ForEach($directions, id: \.self) { $direction in
                        TextField("New Step", text: $direction)
                    }
                    .onDelete {
                        directions.remove(atOffsets: $0)
                    }
                    .onMove {
                        directions.move(fromOffsets: $0, toOffset: $1)
                    }

                    if newStepIsPresented {
                        TextField("New Step", text: $newStep)
                            .onSubmit {
                                if !newStep.trimmingCharacters(in: .whitespaces).isEmpty {
                                    directions.append(newStep)
                                }
                                newStep = ""
                                newStepIsPresented = false
                            }
                    }

                    Button {
                        newStepIsPresented = true
                    } label: {
                        Label("Add Step", systemImage: "plus")
                    }
                }

                Section("Picture") {
                    Button {
//                        cameraIsPresented = true
                    } label: {
                        Label("Photo", systemImage: "camera.fill")
                    }
                    .frame(height: 60)
                    .onDrop(of: [.image], isTargeted: $isTargeted) { imageProvider in
                        print(imageProvider.description)
                        return true
                    }
                }

                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .scrollContentBackground(.hidden)
            .background(BackgroundView())
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
                            name: name,
                            description: description,
                            directions: directions,
                            ingredients: ingredients,
                            notes: notes
                        )
                        recipeData.add(recipe: newRecipe)
                        dismiss()
                    }
                }
            }
        }
    }
}


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
