//
//  SmoothieView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI

struct SmoothieRecipeView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var recipeManager: RecipeManager
    
    var recipe: SmoothieRecipe
    
    @State private var notes = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image(recipe.imageAssetName)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: recipeManager.isFavorite(recipe: recipe) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .padding(10)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                recipeManager.toggleFavorite(recipe: recipe)
                            }
                            .padding()
                    }

                Text(recipe.description)
                
                Text("Ingredients")
                    .font(.headline)
                ForEach(recipe.ingredientMeasurements.indices, id: \.self) { index in
                    HStack(alignment: .top) {
                        Text("\(index + 1). ")
                        Text("\(recipe.ingredientMeasurements[index])")
                    }
                }
                
                Text("Directions")
                    .font(.headline)
                
                ForEach(recipe.directions.indices, id: \.self) { index in
                    HStack(alignment: .top) {
                        Text("\(index + 1). ")
                        Text("\(recipe.directions[index])")
                    }
                }
                
                Text("Notes")
                    .font(.headline)
                TextEditor(text: $notes)
                    .scrollContentBackground(.hidden)
                    .background(colorScheme == .dark ? .darkBgAccent : .lightBgAccent)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(height: 150)
                
                Divider()
                Text("Related Smoothies")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(recipeManager.recipesRelated(to: recipe)) { relatedRecipe in
                        SmoothieThumbnailView(recipe: relatedRecipe)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(recipe.name)
        .background(BackgroundView())
    }
}

// MARK: Previews
struct Smoothie_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SmoothieRecipeView(recipe: .breakfastSmoothie)
        }
        .environmentObject(RecipeManager())
        .previewDisplayName("Rise & Shine")

        
        NavigationStack {
            SmoothieRecipeView(recipe: .bananaBreakfastShake)
        }
        .environmentObject(RecipeManager())
        .previewDisplayName("Banana Breakfast Shake")
    }
}
