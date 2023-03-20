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
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 150))]
    
    private var accentColor: Color {
        colorScheme == .dark ? .darkBgAccent : .lightBgAccent
    }

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
                Group {
                    Text("Ingredients")
                        .font(.headline)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(recipe.ingredients) { ingredient in
                            ZStack {
                                Color.clear
                                    .background(accentColor)
                                    .clipShape(Capsule())
                                
                                Text(ingredient.name)
                                    .lineLimit(1)
                                    .padding(8)
                            }
                        }
                    }
                    ForEach(recipe.ingredientMeasurements.enumeratedArray(), id: \.element) { (offset, element) in
                        HStack(alignment: .top) {
                            Text("\(offset + 1). ")
                            Text(element)
                        }
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
                    .background(accentColor)
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
            SmoothieRecipeView(recipe: .constant(.breakfastBar))
        }
        .environmentObject(SmoothieRecipeData())
        .previewDisplayName("Banana Breakfast Shake")
    }
}
