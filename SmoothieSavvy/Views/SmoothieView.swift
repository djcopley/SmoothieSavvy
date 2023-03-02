//
//  SmoothieView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI

struct SmoothieView: View {
    @Binding var recipe: SmoothieRecipe
    @EnvironmentObject var recipeManager: RecipeManager
            
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image(recipe.imageName)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .padding(10)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                recipe.isFavorite.toggle()
                            }
                            .padding()
                    }

                Text(recipe.description)
                
                Text("Ingredients")
                    .font(.headline)
                Text(recipe.ingredients, format: .list(type: .and))
                
                Text("Directions")
                    .font(.headline)
                
                ForEach(recipe.directions.indices, id: \.self) { index in
                    HStack(alignment: .top) {
                        Text("\(index + 1). ")
                        Text("\(recipe.directions[index])")
                    }
                }
                
                Divider()
                Text("Related Smoothies")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(recipeManager.recipesRelated(to: recipe)) { relatedRecipe in
                        SmoothieThumbnail(recipe: relatedRecipe)
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
struct SmoothieView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SmoothieView(recipe: .constant(.breakfastSmoothie))
        }
        .environmentObject(RecipeManager())
        .previewDisplayName("Rise & Shine")

        
        NavigationStack {
            SmoothieView(recipe: .constant(.bananaBreakfastShake))
        }
        .environmentObject(RecipeManager())
        .previewDisplayName("Banana Breakfast Shake")
    }
}
