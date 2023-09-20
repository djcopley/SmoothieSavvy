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
        guard let _ = selectedIngredients.remove(ingredient) else {
            selectedIngredients.insert(ingredient)
        print(selectedIngredients)
            return
        }
    }
}

#Preview {
    FilterIngredientsSheet(selectedIngredients: .constant(.init()))
        .modelContainer(PreviewSampleData.container)
}
