//
//  IngredientsSection.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct IngredientsSection: View {
    var ingredients: [Ingredient]

    var body: some View {
        if !ingredients.isEmpty {
            RecipeSection("Ingredients") {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(ingredients) { ingredient in
                        IngredientView(ingredient: ingredient)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct IngredientView: View {
    var ingredient: Ingredient
    
    @Environment(\.colorScheme) var colorScheme
    private var accentColor: Color {
        colorScheme == .dark ? .darkBgAccent : .lightBgAccent
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(accentColor)
                .clipShape(Capsule())

            Text("\(ingredient.emoji) \(ingredient.name)")
                .lineLimit(1)
                .padding(8)
        }
    }
}
