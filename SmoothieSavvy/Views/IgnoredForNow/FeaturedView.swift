//
//  FeaturedView.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/2/23.
//

import SwiftUI

struct FeaturedView: View {
    var recipe: SmoothieRecipe
    
    var body: some View {
        Image(recipe.image)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .bottomLeading) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWidth(.compressed)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
            }
    }
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView(recipe: .breakfastSmoothie)
    }
}
