//
//  SmoothieView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI

struct SmoothieRecipeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var recipeData: SmoothieRecipeData
    @Binding var recipe: SmoothieRecipe
    @FocusState var notesIsFocused

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image(recipe.imageAssetName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .overlay(alignment: .bottomTrailing) {
                        favoriteButton
                    }

                Text(recipe.description)
                
                Text("Ingredients")
                    .font(.headline)
                ForEach(recipe.ingredientMeasurements.enumeratedArray(), id: \.element) { (offset, element) in
                    HStack(alignment: .top) {
                        Text("\(offset + 1). ")
                        Text(element)
                    }
                }
                
                Text("Directions")
                    .font(.headline)
                ForEach(recipe.directions.enumeratedArray(), id: \.element) { (offset, element) in
                    HStack(alignment: .top) {
                        Text("\(offset + 1). ")
                        Text(element)
                    }
                }
                
                Text("Notes")
                    .font(.headline)
                TextEditor(text: $recipe.notes)
                    .focused($notesIsFocused)
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
                    ForEach(relatedRecipes) { relatedRecipe in
                        SmoothieThumbnailView(recipe: relatedRecipe)
                    }
                }
                .padding(.horizontal)
            }
        }
        .toolbar {
            if notesIsFocused {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        notesIsFocused = false
                    }
                }
            }
        }
        .navigationTitle(recipe.name)
        .background(BackgroundView())
    }
    
    // MARK: View Builders
    @ViewBuilder
    var favoriteButton: some View {
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
    
    
    /// Recommends a list of smoothie recipes that are similar
    /// - Parameter recipe: recipe from which to generate recommendations
    /// - Returns: similar smoothie recommendations
    var relatedRecipes: [SmoothieRecipe] {
        recipeData.recipes
    }
}

// MARK: Previews
struct Smoothie_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SmoothieRecipeView(recipe: .constant(.breakfastSmoothie))
        }
        .environmentObject(SmoothieRecipeData())
        .previewDisplayName("Rise & Shine")

        
        NavigationStack {
            SmoothieRecipeView(recipe: .constant(.bananaBreakfastShake))
        }
        .environmentObject(SmoothieRecipeData())
        .previewDisplayName("Banana Breakfast Shake")
    }
}
