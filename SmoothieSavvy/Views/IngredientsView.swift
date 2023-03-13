//
//  IngredientsView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct IngredientsView: View {
    // MARK: View State
    @Binding var selectedIngredients: Set<Ingredient.ID>
    @State private var searchText = ""
    
    // MARK: Body property
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(ingredients, id: \.self) { ingredient in
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
                            Text(ingredient.name)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
            .searchable(text: $searchText)
            .navigationTitle("Ingredients")
        }
    }
    
    // MARK: Constants
    private let columns = [GridItem(.adaptive(minimum: 175))]
    
    // MARK: Ingredient helpers
    var ingredients: [Ingredient] {
        guard !searchText.isEmpty else {
            return Ingredient.ingredients
        }
        return Ingredient.ingredients.filter { ingredient in
            ingredient.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
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
        IngredientsView(selectedIngredients: $selectedIngredients)
    }
}
