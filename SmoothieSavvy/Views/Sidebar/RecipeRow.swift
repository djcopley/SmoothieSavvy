//
//  RecipeRow.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            Text(recipe.name)
            Spacer()
            Image(systemName: "heart.fill")
                .font(.subheadline)
                .foregroundColor(.red)
                .opacity(recipe.isFavorite ? 1 : 0)
        }
        .swipeActions(edge: .leading) { swipeActions(recipe: recipe) }
    }    
    
    @ViewBuilder
    private func swipeActions(recipe: Recipe) -> some View {
        Button {
            withAnimation {
                recipe.isFavorite.toggle()
            }
        } label: {
            if recipe.isFavorite {
                Label("Unfavorite", systemImage: "heart.slash.fill")
            } else {
                Label("Favorite", systemImage: "heart.fill")
            }
        }
        .tint(.red)
    }
}

#Preview {
    RecipeRow(recipe: Recipe(name: "Banana Smoothie"))
}
