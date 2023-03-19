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

    @State private var name = ""
    @State private var description = ""

    @State private var ingredients: [Ingredient] = []
    @FocusState private var focusedIngredient: Ingredient?

    @State private var directions: [Direction] = []
    @FocusState private var focusedDirection: Direction?

    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Picture") {
                    Button {
                        
                    } label: {
                        Label("Photo", systemImage: "camera.fill")
                    }
                    .frame(height: 60)
                }
                
                Section("Details") {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }

                Section("Ingredients") {
                    ForEach($ingredients) { $ingredient in
                        TextField("New Ingredient", text: $ingredient.name)
                            .focused($focusedIngredient, equals: ingredient)
                    }
                    .onDelete {
                        ingredients.remove(atOffsets: $0)
                    }
                    .onMove {
                        ingredients.move(fromOffsets: $0, toOffset: $1)
                    }

                    Button {
                        let newIngredient = Ingredient(name: "")
                        ingredients.append(newIngredient)
                        focusedIngredient = newIngredient
                    } label: {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }

                Section("Directions") {
                    ForEach($directions) { $direction in
                        TextField("New Step", text: $direction.text)
                            .focused($focusedDirection, equals: direction)
                    }
                    .onDelete {
                        directions.remove(atOffsets: $0)
                    }
                    .onMove {
                        directions.move(fromOffsets: $0, toOffset: $1)
                    }

                    Button {
                        let newStep = Direction(text: "")
                        directions.append(newStep)
                        focusedDirection = newStep
                    } label: {
                        Label("Add Step", systemImage: "plus")
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
                            directions: directions.map { $0.text },
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
