//
//  FilterIngredientsSheet.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI
import SwiftData

struct FilterIngredientsSheet: View {
    @Binding var selectedIngredients: Set<Ingredient>
    
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: \Ingredient.name) var ingredients: [Ingredient]
    
    private let columns = [GridItem(.adaptive(minimum: 175))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(ingredients) { ingredient in
                        IngredientItem(ingredient: ingredient, isSelected: selectedIngredients.contains(ingredient)) {
                            userTapped(ingredient)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradientBackground())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") { dismiss() }
                }
            }
            .navigationTitle("Ingredients")
        }
    }
    
    // MARK: Ingredient helpers
    
    func userTapped(_ ingredient: Ingredient) {
        if selectedIngredients.contains(ingredient) {
            selectedIngredients.remove(ingredient)
        } else {
            selectedIngredients.insert(ingredient)
        }
    }
}

struct IngredientItem: View {
    let ingredient: Ingredient
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 3)
                        .foregroundColor(.accentColor)
                        .opacity(isSelected ? 1 : 0)
                )
                .frame(height: 60)
                .onTapGesture {
                    onTap()
                }
            Text("\(ingredient.emoji) \(ingredient.name)")
        }
    }
}

#Preview {
    FilterIngredientsSheet(selectedIngredients: .constant(.init()))
        .modelContainer(PreviewSampleData.container)
}
