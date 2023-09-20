//
//  HeaderSection.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 9/17/23.
//

import SwiftUI

struct HeaderSection: View {
    var recipe: Recipe

    var body: some View {
        HeaderImage(recipe: recipe)
            .padding(.horizontal)
    }
}

struct HeaderImage: View {
    var recipe: Recipe
    
    var body: some View {
        smoothieImage
            .resizable()
            .scaledToFill()
            .frame(maxHeight: 300)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .overlay(alignment: .bottomTrailing) {
                favoriteButton
            }
    }

    @ViewBuilder
    var favoriteButton: some View {
        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
            .foregroundColor(.red)
            .padding(10)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                withAnimation {
                    recipe.isFavorite.toggle()
                }
            }
            .padding()
    }
    
    var smoothieImage: Image {
        guard let uiImage = recipe.uiImage else {
            return Image("defaultSmoothie")
        }
        return Image(uiImage: uiImage)
    }
}
