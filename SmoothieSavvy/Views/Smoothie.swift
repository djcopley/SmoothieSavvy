//
//  SmoothieView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI

struct Smoothie: View {
    @Binding var recipe: SmoothieRecipe
    @EnvironmentObject var recipeManager: RecipeManager
    
    @State private var isFavorite = false
            
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .padding(10)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                isFavorite.toggle()
                            }
                            .padding()
                    }

                Text(recipe.description)
                
                Text("Ingredients")
                    .font(.headline)
                ForEach(recipe.ingredients.indices, id: \.self) { index in
                    HStack(alignment: .top) {
                        Text("\(index + 1). ")
                        Text("\(recipe.ingredients[index])")
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
        .background(Background())
    }
}

// MARK: Previews
struct Smoothie_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Smoothie(recipe: .constant(.breakfastSmoothie))
        }
        .environmentObject(RecipeManager())
        .previewDisplayName("Rise & Shine")

        
        NavigationStack {
            Smoothie(recipe: .constant(.bananaBreakfastShake))
        }
        .environmentObject(RecipeManager())
        .previewDisplayName("Banana Breakfast Shake")
    }
}
