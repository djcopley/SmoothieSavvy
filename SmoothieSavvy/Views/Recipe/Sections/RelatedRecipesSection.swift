//
//  RelatedRecipesSection.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct RelatedSmoothiesSection: View {
    var relatedRecipes: [Recipe]

    var body: some View {
        if !relatedRecipes.isEmpty {
            VStack(spacing: 10) {
                Text("Related Smoothies")
                    .font(.headline)
                    .padding(.horizontal)
                SmoothieThumbnailsScrollView(recipes: relatedRecipes)
            }
        }
    }
}

struct SmoothieThumbnailsScrollView: View {
    var recipes: [Recipe]

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(recipes) { recipe in
                    SmoothieThumbnail(recipe: recipe)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SmoothieThumbnail: View {
    var recipe: Recipe
    
    var body: some View {
        if let uiImage = recipe.uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 80)
                .blur(radius: 4)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(alignment: .center) {
                    Text(recipe.name)
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                }
        }
    }
}
