//
//  SmoothieView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 2/19/23.
//

import SwiftUI

struct SmoothieView: View {
    @Binding var recipe: SmoothieRecipe
            
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
                Text(recipe.directions)
                
                Divider()
                Text("Related Smoothies")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            // MARK: Related smoothies
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 80)
                        .blur(radius: 3)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 80)
                        .blur(radius: 3)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 80)
                        .blur(radius: 3)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 80)
                        .blur(radius: 3)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
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
            SmoothieView(recipe: .constant(.riseAndShine))
        }
        .previewDisplayName("Rise & Shine")

        
        NavigationStack {
            SmoothieView(recipe: .constant(.bananaBreakfastShake))
        }
        .previewDisplayName("Banana Breakfast Shake")
    }
}
