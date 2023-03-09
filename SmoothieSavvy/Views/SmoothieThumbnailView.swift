//
//  SmoothieThumbnailView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/1/23.
//

import SwiftUI

struct SmoothieThumbnailView: View {
    var recipe: SmoothieRecipe
    
    var body: some View {
        Image(recipe.image)
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

struct SmoothieThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        SmoothieThumbnailView(recipe: SmoothieRecipe.breakfastSmoothie)
    }
}
