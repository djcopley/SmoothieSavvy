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
            if let image = recipe.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            Text(recipe.name)
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
    MainActor.assumeIsolated {
        let container = PreviewSampleData.container
        
        return List {
            Section("Favorites") {
                RecipeRow(recipe: .appleSpinachKiwiSmoothie)
            }
            Section("Smoothies") {
                RecipeRow(recipe: .strawberryBananaSmoothie)
            }
        }
        .modelContainer(container)
    }
}
