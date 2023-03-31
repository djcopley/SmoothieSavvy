//
//  SmoothieThumbnailView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

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

//struct SmoothieThumbnail_Previews: PreviewProvider {
//    static var previews: some View {
//        SmoothieThumbnail(recipe: SmoothieRecipe.breakfastSmoothie)
//    }
//}
