//
//  IngredientSelecter.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct SelectIngredientsView: View {
    // MARK: View State
    @Binding var selectedIngredients: Set<Ingredient.ID>
    @State private var searchText = ""
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        animation: .default
    ) private var ingredients: FetchedResults<Ingredient>
    
    // MARK: Body property
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
                                        .opacity(selectedIngredients.contains(ingredient.id) ? 1 : 0)
                                )
                                .frame(height: 60)
                                .onTapGesture {
                                    userTapped(ingredient)
                                }
                            Text("\(ingredient.emoji) \(ingredient.name)")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GradientBackground())
            .searchable(text: $searchText)
            .toolbar {
                Button("Done") { dismiss() }
            }
            .navigationTitle("Ingredients")
        }
    }
    
    // MARK: Constants
    private let columns = [GridItem(.adaptive(minimum: 175))]
    
    // MARK: Ingredient helpers
    
    func userTapped(_ ingredient: Ingredient) {
        guard let _ = selectedIngredients.remove(ingredient.id) else {
            selectedIngredients.insert(ingredient.id)
            return
        }
    }
}

struct Ingredients_Previews: PreviewProvider {
    @State static var selectedIngredients: Set<Ingredient.ID> = []
    
    static var previews: some View {
        SelectIngredientsView(selectedIngredients: $selectedIngredients)
    }
}
