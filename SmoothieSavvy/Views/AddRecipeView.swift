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

    @State private var name = ""
    @State private var description = ""

    @State private var ingredients: [Ingredient] = []
    @State private var newIngredientIsPresented = false
    @State private var newIngredientName = ""
    @FocusState private var focusedIngredientIndex: Int?

    @State private var directions: [String] = []
    @State private var newStepIsPresented = false
    @State private var newStep = ""
    @FocusState private var focusedStepIndex: Int?

    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }

                Section("Ingredients") {
                    ForEach(ingredients.indices, id: \.self) { index in
                        TextField(ingredients[index].name, text: $ingredients[index].name)
                            .tag(index)
                            .focused($focusedIngredientIndex, equals: index)
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
                            .focused($focusedIngredientIndex, equals: -1)
                    }

                    Button {
                        focusedIngredientIndex = -1
                        newIngredientIsPresented = true
                    } label: {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }

                Section("Directions") {
                    ForEach(directions, id: \.self) { direction in
                        Text(direction)
                    }
                    .onDelete {
                        directions.remove(atOffsets: $0)
                    }
                    .onMove {
                        directions.move(fromOffsets: $0, toOffset: $1)
                    }

                    if newStepIsPresented {
                        TextField("New Ingredient", text: $newStep)
                            .onSubmit {
                                if !newStep.trimmingCharacters(in: .whitespaces).isEmpty {
                                    directions.append(newStep)
                                }
                                newStep = ""
                                newStepIsPresented = false
                            }
                            .focused($focusedStepIndex, equals: -1)
                    }

                    Button {
                        focusedStepIndex = -1
                        newStepIsPresented = true
                    } label: {
                        Label("Add Step", systemImage: "plus")
                    }
                }

                Section("Picture") {
                    Button {
                        // TODO: Add ability to import images from photo library
                    } label: {
                        Label("Photo", systemImage: "camera.fill")
                    }
                    .frame(height: 60)
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
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
