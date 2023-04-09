//
//  IngredientSelecter.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct SelectIngredientsView: View {
    @Binding var selectedIngredients: Set<Ingredient>

    @Environment(\.dismiss) var dismiss

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name_)],
        animation: .default
    ) private var ingredients: FetchedResults<Ingredient>

    @State private var searchText = ""
    private var query: Binding<String> {
        Binding {
            searchText
        } set: { queryText in
            searchText = queryText
            ingredients.nsPredicate = queryText.isEmpty ? nil : NSPredicate(format: "name_ BEGINSWITH[c] %@", queryText)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(ingredients) { ingredient in
                        ZStack {
                            Color.clear
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 3)
                                        .foregroundColor(.accentColor)
                                        .opacity(selectedIngredients.contains(ingredient) ? 1 : 0)
                                )
                                .frame(height: 60)
                                .onTapGesture {
                                    userTapped(ingredient)
                                }
                            Text("\(ingredient.emoji) \(ingredient.name)")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradientBackground())
            .searchable(text: query)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") { dismiss() }
                }
            }
            .navigationTitle("Ingredients")
        }
    }

    // MARK: Constants

    private let columns = [GridItem(.adaptive(minimum: 175))]

    // MARK: Ingredient helpers

    func userTapped(_ ingredient: Ingredient) {
        guard let _ = selectedIngredients.remove(ingredient) else {
            selectedIngredients.insert(ingredient)
        print(selectedIngredients)
            return
        }
    }
}

struct Ingredients_Previews: PreviewProvider {
    @State static var selectedIngredients: Set<Ingredient> = []

    static var previews: some View {
        SelectIngredientsView(selectedIngredients: $selectedIngredients)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
