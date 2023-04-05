//
//  HeaderImage.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/20/23.
//

import SwiftUI

struct HeaderImage: View {
    @ObservedObject var recipe: Recipe
    
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
                recipe.isFavorite.toggle()
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

struct HeaderImage_Previews: PreviewProvider {
    static let moc = PersistenceController.preview.container.viewContext
    static let recipe = try! moc.fetch(Recipe.fetchRequest()).first!
    
    static var previews: some View {
        HeaderImage(recipe: recipe)
            .environment(\.managedObjectContext, moc)
    }
}
