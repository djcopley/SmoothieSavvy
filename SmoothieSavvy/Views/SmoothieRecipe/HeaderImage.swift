//
//  HeaderImage.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/20/23.
//

import SwiftUI

struct HeaderImage: View {
    var imageAssetName: String
    @Binding var isFavorite: Bool
    
    init(_ imageAssetName: String, isFavorite: Binding<Bool>) {
        self.imageAssetName = imageAssetName
        _isFavorite = isFavorite
    }

    var body: some View {
        Image(imageAssetName)
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
}

struct HeaderImage_Previews: PreviewProvider {
    static var previews: some View {
        HeaderImage("defaultSmoothie", isFavorite: .constant(true))
    }
}
